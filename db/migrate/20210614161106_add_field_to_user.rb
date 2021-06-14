class AddFieldToUser < ActiveRecord::Migration[ 6.1 ]
  def change
    add_column :users, :type, :string, null: false, default: 'User'
  end
end
