class Task < ApplicationRecord
  belongs_to :column

  validates :title, presence: true
  validates :difficulty,
              presence: true,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: 1,
                less_than_or_equal_to: 3
              }
end
