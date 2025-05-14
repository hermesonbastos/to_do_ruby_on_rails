class AddConcludedAtToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :concluded_at, :datetime
  end
end
