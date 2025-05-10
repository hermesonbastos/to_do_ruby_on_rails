class User < ApplicationRecord
  has_secure_password

  validates :name,  presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :profile_photo,
            length: { maximum: 1.megabyte },
            allow_nil: true

  def token_expired?
    expires_at < Time.now
  end

  def refresh_google_token!
    client = Signet::OAuth2::Client.new(
      client_id: ENV["GOOGLE_CLIENT_ID"],
      client_secret: ENV["GOOGLE_CLIENT_SECRET"],
      token_credential_uri: "https://accounts.google.com/o/oauth2/token",
      refresh_token: refresh_token
    )
    client.refresh!
    update!(
      token: client.access_token,
      expires_at: Time.now + client.expires_in
    )
  end
end
