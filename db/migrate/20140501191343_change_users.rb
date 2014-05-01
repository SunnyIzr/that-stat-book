class ChangeUsers < ActiveRecord::Migration
  def change
    add_reference :users, :school, index: true
    remove_column :users, :school
    remove_column :users, :school_state
  end
end
