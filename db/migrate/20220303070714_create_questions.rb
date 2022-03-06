class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :name
      t.string :correct_option
      t.string :option1
      t.string :option2
      t.string :option3
      t.references :exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
