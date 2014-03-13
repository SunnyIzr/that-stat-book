class ChangeEmailInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :email, :emaill
  end
end
