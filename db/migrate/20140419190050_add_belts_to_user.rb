class AddBeltsToUser < ActiveRecord::Migration
  def change
    add_column :users, :belts, :text
  end
end
