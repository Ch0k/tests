class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.string :title, null: false
      t.references :category, null: false, foreign_key: true
      t.integer :level, null: false, default: 1
      t.timestamps
    end
  end
end
