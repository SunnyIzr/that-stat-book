class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :school
      t.string :state
      t.string :country
    end
  end
end
