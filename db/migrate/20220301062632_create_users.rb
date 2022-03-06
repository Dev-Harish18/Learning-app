class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mobile
      t.string :email
      t.date :dob
      t.string :password_digest
      t.references :board, null: false, foreign_key: true
      t.references :grade, null: false, foreign_key: true

      t.timestamps
    end
  end
end
