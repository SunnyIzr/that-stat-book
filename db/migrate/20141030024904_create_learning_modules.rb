class CreateLearningModules < ActiveRecord::Migration
  def change
    create_table :learning_modules do |t|
      t.string :title
      t.text :description
      t.belongs_to :lesson
    end
  end
end
