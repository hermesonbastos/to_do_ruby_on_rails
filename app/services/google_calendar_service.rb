class GoogleCalendarService
  def initialize(user)
    @user = user
  end

  def create_or_update_event_for_task(task)
    return if task.due_date.blank?
    time_zone = "UTC"
    start_time = task.due_date + 3.hour # TODO: Verificar pq ta indo 3h a menos, paliativo coloquei + 3.hour
    end_time = start_time + 1.hour

    event = Google::Apis::CalendarV3::Event.new(
      summary: task.title,
      location: "",
      description: task.description,
      start: {
        date_time: start_time.iso8601,
        time_zone: time_zone
      },
      end: {
        date_time: end_time.iso8601,
        time_zone: time_zone
      },
      attendees: [
        { email: @user.email }
      ],
      reminders: {
        use_default: true
      }
    )

    client = authorized_client

    if task.google_event_id.present?
      begin
        result = client.update_event("primary", task.google_event_id, event)
      rescue Google::Apis::ClientError => e
        if e.status_code == 404
          result = create_new_event(client, event, task)
        else
          raise e
        end
      end
    else
      result = create_new_event(client, event, task)
    end

    result.html_link
  rescue Google::Apis::Error => e
    Rails.logger.error "Erro ao manipular evento: #{e.message}"
    nil
  end

  def delete_event_for_task(task)
    return unless task.google_event_id.present?

    client = authorized_client
    client.delete_event("primary", task.google_event_id)
  rescue Google::Apis::Error => e
    Rails.logger.error "Erro ao excluir evento: #{e.message}"
  end

  private

  def create_new_event(client, event, task)
    result = client.insert_event("primary", event)
    task.update(google_event_id: result.id)
    result
  end

  def authorized_client
    client = Google::Apis::CalendarV3::CalendarService.new
    client.client_options.application_name = "ToDone"
    client.authorization = user_credentials
    client
  end

  def user_credentials
    if @user.provider == "google_oauth2" && @user.uid.present?
      auth = Signet::OAuth2::Client.new(
        token_credential_uri: "https://oauth2.googleapis.com/token",
        client_id: ENV["GOOGLE_CLIENT_ID"],
        client_secret: ENV["GOOGLE_CLIENT_SECRET"],
        refresh_token: @user.refresh_token
      )

      if @user.token_expires_at && @user.token_expires_at < Time.now
        if @user.refresh_token.present?
          auth.refresh!
          @user.update(
            token: auth.access_token,
            token_expires_at: Time.now + auth.expires_in.seconds
          )
        else
          raise "Usuário não possui refresh_token salvo. Peça para logar novamente com Google."
        end
      else
        auth.access_token = @user.token
      end

      auth
    else
      raise "Usuário não autenticado via Google"
    end
  end
end
