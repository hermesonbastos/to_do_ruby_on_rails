class User < ApplicationRecord
  has_secure_password

  has_many :boards, dependent: :destroy

  validates :name,  presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :profile_photo,
            length: { maximum: 1.megabyte },
            allow_nil: true
end
