class Task < ApplicationRecord
  belongs_to :column
  has_and_belongs_to_many :labels

  validates :title, presence: true
  validates :difficulty,
              presence: true,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: 1,
                less_than_or_equal_to: 3
              }
end
