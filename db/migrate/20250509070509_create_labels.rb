class CreateLabels < ActiveRecord::Migration[8.0]
  def change
    create_table :labels do |t|
      t.string :title, null: false
      t.string :color, null: false

      t.timestamps
    end
  end
end
