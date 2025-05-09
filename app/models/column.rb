class Column < ApplicationRecord
  belongs_to :board

  validates :title, presence: true
  validates :position,
              presence: true,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0
              }
  validates :is_done_column, inclusion: { in: [ true, false ] }
end
