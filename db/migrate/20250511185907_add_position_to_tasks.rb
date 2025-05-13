class AddPositionToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :position, :integer, null: false, default: 0
    add_index :tasks, [ :column_id, :position ]
  end
end
