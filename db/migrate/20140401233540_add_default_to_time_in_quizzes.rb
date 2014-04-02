class AddDefaultToTimeInQuizzes < ActiveRecord::Migration
  def change
    change_column :quizzes, :time, :integer, default: 0
  end
end
