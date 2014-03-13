class AddLevelsToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :level, :integer
  end
end
