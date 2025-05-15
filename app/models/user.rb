class User < ApplicationRecord
  has_secure_password

  has_many :boards, dependent: :destroy

  validates :name,  presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.from_omniauth(auth)
    user = find_or_initialize_by(email: auth.info.email)

    user.name = auth.info.name
    user.provider = auth.provider
    user.uid = auth.uid

    user.token = auth.credentials.token
    user.refresh_token = auth.credentials.refresh_token if auth.credentials.refresh_token.present?
    user.token_expires_at = Time.at(auth.credentials.expires_at)

    user.password = SecureRandom.hex(16) if user.new_record?

    user.save
    user
  end
end
