class Column < ApplicationRecord
  belongs_to :board

  validates :title, presense: true
  validates :position,
              presense: true,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0
              }
  validates :is_done_column, inclusion: { in: [ true, false ] }
end
