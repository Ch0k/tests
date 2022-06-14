class CreateExamsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :tests_users do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :test, foreign_key: true
      t.integer :correct_question, default: 0
      t.references :current_question, foreign_key: {to_table: :questions}
      t.timestamps
    end
  end
end

