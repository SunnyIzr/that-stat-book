class RemoveEmaillFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :emaill
  end
end
