require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets.rb'

class AuthController < ApplicationController
  def new
    # step: email, password ou register
    @step = params[:step] || "email"
    @user = User.new(email: session[:auth_email])
  end

  def google_auth
    auth = request.env['omniauth.auth']

    # 1. Vincular o e-mail do usuário local com o do Google
    # Exemplo: supondo que você tenha um current_user
    if current_user
      current_user.update(
        google_email: auth.info.email,
        google_token: auth.credentials.token,
        google_refresh_token: auth.credentials.refresh_token,
        google_token_expires_at: Time.at(auth.credentials.expires_at)
      )
    end

    # 2. Criar evento mock no Google Calendar
    criar_evento_google_calendar(auth.credentials.token, auth.credentials.refresh_token)

    redirect_to root_path, notice: "Google vinculado e evento criado!"
  end

  def criar_evento_google_calendar(token, refresh_token)
    client = Google::Apis::CalendarV3::CalendarService.new
    client.authorization = Signet::OAuth2::Client.new(
      access_token: token,
      refresh_token: refresh_token,
      client_id: ENV["GOOGLE_CLIENT_ID"],
      client_secret: ENV["GOOGLE_CLIENT_SECRET"],
      token_credential_uri: "https://accounts.google.com/o/oauth2/token"
    )

    evento = Google::Apis::CalendarV3::Event.new(
      summary: "Evento de Teste Mock",
      description: "Este é um evento criado automaticamente após vincular o Google.",
      start: Google::Apis::CalendarV3::EventDateTime.new(date_time: (Time.now + 1.hour).iso8601),
      end: Google::Apis::CalendarV3::EventDateTime.new(date_time: (Time.now + 2.hours).iso8601)
    )

    client.insert_event('primary', evento)
  end

  def create
    case params[:step]
    when "email"
      email = params[:auth][:email].downcase
      session[:auth_email] = email

      if User.exists?(email: email)
        redirect_to auth_path(step: "password")
      else
        @user = User.new(email: email)
        @step = "register"
        render :new, status: :unprocessable_entity
      end

    when "password"
      user = User.find_by(email: session[:auth_email])
      if user&.authenticate(params[:auth][:password])
        session[:user_id] = user.id
        session.delete(:auth_email)
        redirect_to root_path, notice: "Login efetuado com sucesso."
      else
        flash.now[:alert] = "Senha inválida."
        @step = "password"
        render :new, status: :unprocessable_entity
      end

    when "register"
      @user = User.new(user_params)
      @user.email = session[:auth_email]
      if @user.save
        session[:user_id] = @user.id
        session.delete(:auth_email)
        redirect_to root_path, notice: "Conta criada com sucesso."
      else
        @step = "register"
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def user_params
    params.require(:auth).permit(:name, :password, :password_confirmation)
  end

  def passthru
    head :not_found
  end
end
