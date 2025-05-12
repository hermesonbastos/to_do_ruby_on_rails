class AddBoardRefToLabels < ActiveRecord::Migration[8.0]
  def change
    add_reference :labels, :board, null: false, foreign_key: true
  end
end
