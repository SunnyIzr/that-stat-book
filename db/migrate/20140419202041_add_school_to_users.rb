class AddSchoolToUsers < ActiveRecord::Migration
  def change
    add_column :users, :school, :string
    add_column :users, :school_state, :string
  end
end
