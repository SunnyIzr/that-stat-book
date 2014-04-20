class RemoveDescFromLessons < ActiveRecord::Migration
  def change
    remove_column :lessons, :description
  end
end
