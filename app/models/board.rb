class Board < ApplicationRecord
  belongs_to :user
  has_many :columns, -> { order(position: :asc) }, dependent: :destroy

  validates :name, presence: true
  validates :banner, length: { maximum: 1.megabyte }, allow_nil: true
end
