class Label < ApplicationRecord
  has_and_belongs_to_many :tasks

  validates :title, presence: true
  validates :color, presence: true
end
