class ChangeTimeInQuizzes < ActiveRecord::Migration
  def change
    change_column :quizzes, :time, :integer, default: 30
  end
end
