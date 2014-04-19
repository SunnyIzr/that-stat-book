class AddBeltsRefToLessons < ActiveRecord::Migration
  def change
    add_reference :lessons, :belt, index: true
  end
end
