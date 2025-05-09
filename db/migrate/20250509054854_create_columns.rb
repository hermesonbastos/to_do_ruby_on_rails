class CreateColumns < ActiveRecord::Migration[8.0]
  def change
    create_table :columns do |t|
      t.references :board, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.datetime :due_date
      t.integer :position, null: false, default: 0
      t.boolean :is_done_column, null: false, default: false

      t.timestamps
    end

    add_index :columns, [ :board_id, :position ]
  end
end
