class AddProfessorToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :professor, :boolean, :default => false
  end
  
  def self.down
    remove_column :users, :professor
  end
end
