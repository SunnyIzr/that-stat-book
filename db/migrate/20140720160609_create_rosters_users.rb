class CreateRostersUsers < ActiveRecord::Migration
  def change
    create_table :rosters_users do |t|
      t.belongs_to :roster
      t.belongs_to :user
      t.timestamps
    end
  end
end
