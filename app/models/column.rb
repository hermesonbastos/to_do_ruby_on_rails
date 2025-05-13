class Column < ApplicationRecord
  belongs_to :board
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy

  validates :name, presence: true
  validates :position, presence: true, numericality: { only_integer: true }

  before_validation :set_position, on: :create

  private

  def set_position
    return if position.present?
    max_position = board.columns.maximum(:position)
    self.position = (max_position || -1) + 1
  end
end
