class RemoveDescriptionFromColumns < ActiveRecord::Migration[8.0]
  def change
    remove_column :columns, :description, :text
  end
end
