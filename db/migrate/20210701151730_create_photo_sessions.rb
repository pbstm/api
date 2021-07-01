class CreatePhotoSessions < ActiveRecord::Migration[ 6.1 ]
  def change
    create_table :photo_sessions do | t |
      t.string :title
      t.text :description
      t.bigint :photographer_id
      t.bigint :foreign_key_to_users
      t.string :cover
      t.string :mount_image

      t.timestamps
    end
  end
end
