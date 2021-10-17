class CreatePhotoSessions < ActiveRecord::Migration[ 6.1 ]
  def change
    create_table :photo_sessions do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :cover
      t.references :photographer, foreign_key: { to_table: :users }, null: false
      t.references :location, foreign_key: { on_delete: :cascade }, null: false

      t.timestamps
    end
  end
end
