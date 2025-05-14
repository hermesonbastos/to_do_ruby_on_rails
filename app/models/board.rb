class Board < ApplicationRecord
  belongs_to :user
  has_many :labels,  dependent: :destroy
  has_many :columns, -> { order(position: :asc) }, dependent: :destroy

  validates :name, presence: true
  validates :banner, length: { maximum: 1.megabyte }, allow_nil: true
  after_create :create_default_columns

  def create_default_columns
    columns.create!([{ name: 'To do' }, { name: 'Doing' }, { name: 'Done' }])
  end
end
