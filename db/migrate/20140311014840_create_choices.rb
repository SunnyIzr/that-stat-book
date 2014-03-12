class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.text :choice
      t.boolean :is_correct
      t.timestamps
    end
  end
end
