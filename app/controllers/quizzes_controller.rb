class QuizzesController < ApplicationController
  helper ApplicationHelper
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
      UserMailer.successful_pass_email(@user) if @quiz.pass?
      render :show
    else
      render :incomplete
    end
  end
  
  def countdown
    @quiz = Quiz.find(params[:quiz_id])
    @quiz.time -= 1
    @quiz.save
    time = ApplicationHelper.time(@quiz.time)
    render text: time.to_s
  end
  
  def incomplete
    @quiz = Quiz.find(params[:quiz_id])
    @quiz.finish_incomplete
    redirect_to quiz_path(@quiz)
  end

  private
  def quiz_params
    params.permit(:lesson_id)
  end
end
