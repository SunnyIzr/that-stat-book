class AddTypeToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :roster_id, :integer
  end
end
