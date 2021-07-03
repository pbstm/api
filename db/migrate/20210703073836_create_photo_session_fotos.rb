class CreatePhotoSessionFotos < ActiveRecord::Migration[ 6.1 ]
  def change
    create_table :photo_session_photos do | t |
      t.string :photo, null: false
      t.references :photo_session, foreign_key: { on_delete: :cascade }, null: false

      t.timestamps
    end
  end
end
