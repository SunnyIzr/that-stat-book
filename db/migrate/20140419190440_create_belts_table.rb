class CreateBeltsTable < ActiveRecord::Migration
  def change
    create_table :belts do |t|
      t.string :belt
    end
  end
end
