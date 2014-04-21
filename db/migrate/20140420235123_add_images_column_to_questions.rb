class AddImagesColumnToQuestions < ActiveRecord::Migration
  def change
    add_attachment :questions, :image
  end
end
