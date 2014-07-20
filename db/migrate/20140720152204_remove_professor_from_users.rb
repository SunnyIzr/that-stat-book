class RemoveProfessorFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :professor
  end
end
