class DropDescriptionFromLearningModule < ActiveRecord::Migration
  def change
    remove_column :learning_modules, :description
  end
end
