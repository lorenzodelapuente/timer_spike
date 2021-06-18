class AddColumnTdDataToUserData < ActiveRecord::Migration[6.1]
  def change
    add_column :user_data, :toggl_data, :string
    add_column :user_data, :harvest_data, :string
    add_column :user_data, :clockify_data, :string
  end
end
