class Board < ApplicationRecord
  belongs_to :user

  validates :name,   presence: true
  validates :banner, length: { maximum: 1.megabyte }, allow_nil: true
end
