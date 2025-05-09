class RemoveDueDateFromColumns < ActiveRecord::Migration[8.0]
  def change
    remove_column :columns, :due_date, :datetime
  end
end
