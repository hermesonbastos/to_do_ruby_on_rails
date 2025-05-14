class Task < ApplicationRecord
  belongs_to :column
  has_and_belongs_to_many :labels
  acts_as_list scope: :column, column: :position

  validates :title, presence: true
  validates :difficulty,
              presence: true,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: 1,
                less_than_or_equal_to: 3
              }
  validates :position, presence: true, numericality: { only_integer: true }
  default_scope { order(position: :asc) }
  before_create :set_position_if_nil

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

  def set_position_if_nil
    return if position.present?

    max_position = column.tasks.maximum(:position) || -1
    self.position = max_position + 1
  end
end
