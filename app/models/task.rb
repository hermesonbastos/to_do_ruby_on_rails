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
  validates :position, presence: true, numericality: { only_integer: true }

  before_validation :set_position, on: :create

  DIFFICULTY_LABELS = {
    1 => "S",
    2 => "M",
    3 => "L"
  }

  def difficulty_label
    DIFFICULTY_LABELS[difficulty] || "Desconhecido"
  end

  def due_date_formatted
    due_date&.strftime("%d/%m/%Y %H:%M")
  end

  private

  def set_position
    return if position.present?
    max_position = column.tasks.maximum(:position)
    self.position = (max_position || -1) + 1
  end
end
