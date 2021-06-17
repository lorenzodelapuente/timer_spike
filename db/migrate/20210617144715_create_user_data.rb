class CreateUserData < ActiveRecord::Migration[6.1]
  def change
    create_table :user_data do |t|
      t.string :userName
      t.string :userData

      t.timestamps
    end
  end
end
