class UpdateTimeInQuizzes < ActiveRecord::Migration
  def change
    change_column :quizzes, :time, :integer, default: 1800
  end
end
