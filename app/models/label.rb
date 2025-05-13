class Label < ApplicationRecord
  belongs_to :board
  has_and_belongs_to_many :tasks

  validates :title, presence: true
  validates :color, presence: true
end
