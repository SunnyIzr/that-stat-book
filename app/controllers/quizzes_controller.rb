class QuizzesController < ApplicationController
  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      redirect_to new_question_path()
    else
      render text: 'FAIL!'
    end
  end
end
