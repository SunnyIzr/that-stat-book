class QuizzesController < ApplicationController
  def create
    @quiz = Quiz.new(lesson_id: params[:lesson_id], user_id: current_user.id)
    if @quiz.save
      redirect_to new_question_path()
    else
      render text: 'FAIL!'
    end
  end

  private
  def quiz_params
    params.permit(:lesson_id)
  end
end
