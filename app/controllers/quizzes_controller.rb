class QuizzesController < ApplicationController
  def create
    if current_user.last_incomplete_quiz(params[:lesson_id].to_i).nil?
      @quiz = Quiz.new(lesson_id: params[:lesson_id], user_id: current_user.id)
    else
      @quiz = current_user.last_incomplete_quiz(params[:lesson_id].to_i)
    end
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
    if @quiz.complete?
      @user.update_belts
      render :show
    else
      render :incomplete
    end
  end

  private
  def quiz_params
    params.permit(:lesson_id)
  end
end
