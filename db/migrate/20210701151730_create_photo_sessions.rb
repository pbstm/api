class CreatePhotoSessions < ActiveRecord::Migration[ 6.1 ]
  def change
    create_table :photo_sessions do | t |
      t.string :title
      t.text :description
      t.bigint :photographer_id
      t.string :foreign_key
      t.string :to
      t.bigint :user
      t.string :cover
      t.string :mount
      t.string :image

      t.timestamps
    end
  end
end
