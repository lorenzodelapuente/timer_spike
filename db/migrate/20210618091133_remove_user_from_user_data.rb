class RemoveUserFromUserData < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_data, :userName, :string
    remove_column :user_data, :userData, :string
  end
end
