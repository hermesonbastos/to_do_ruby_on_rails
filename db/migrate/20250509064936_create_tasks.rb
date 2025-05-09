class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.references :column, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.integer :difficulty, null: false, default: 1
      t.datetime :due_date

      t.timestamps
    end
  end
end
