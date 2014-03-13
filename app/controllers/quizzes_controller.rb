class QuizzesController < ApplicationController
  def create
    @quiz = Quiz.new(lesson_id: params[:lesson_id], user_id: current_user.id)
    if @quiz.save
      redirect_to ("/quizzes/#{@quiz.id}/new-question")
    else
      render text: 'FAIL!'
    end
  end

  def show
    @quiz = Quiz.find(params[:id])
    @new_quiz = Quiz.new
    @user = current_user
  end

  private
  def quiz_params
    params.permit(:lesson_id)
  end
end
