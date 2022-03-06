class CreateUserContents < ActiveRecord::Migration[7.0]
  def change
    create_table :user_contents do |t|
      t.string :notes
      t.boolean :upvoted
      t.boolean :downvoted
      t.references :user, null: false, foreign_key: true
      t.references :content, null: false, foreign_key: true

      t.timestamps
    end
  end
end
