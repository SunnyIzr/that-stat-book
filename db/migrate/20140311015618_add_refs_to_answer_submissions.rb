class AddRefsToAnswerSubmissions < ActiveRecord::Migration
  def change
    add_reference :answer_submissions, :quiz, index: true
    add_reference :answer_submissions, :choice, index: true
  end
end
