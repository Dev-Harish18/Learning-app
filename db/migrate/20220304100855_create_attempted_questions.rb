class CreateAttemptedQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :attempted_questions do |t|
      t.string :submitted_answer
      t.integer :score
      t.references :attempt, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
