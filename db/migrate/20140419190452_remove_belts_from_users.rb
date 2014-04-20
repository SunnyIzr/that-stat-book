class RemoveBeltsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :belts, :text
  end
end
