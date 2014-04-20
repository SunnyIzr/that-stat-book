class CreateBeltsUsers < ActiveRecord::Migration
  def change
    create_table :belts_users do |t|
      t.belongs_to :belt
      t.belongs_to :user
    end
  end
end
