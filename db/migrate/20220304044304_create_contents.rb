class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.string :title
      t.string :file_type
      t.string :path
      t.string :description
      t.references :chapter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
