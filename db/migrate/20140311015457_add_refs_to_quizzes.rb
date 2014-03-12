class AddRefsToQuizzes < ActiveRecord::Migration
  def change
    add_reference :quizzes, :user, index: true
    add_reference :quizzes, :lesson, index: true

  end
end
