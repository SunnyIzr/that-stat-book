class QuizzesController < ApplicationController
  helper ApplicationHelper
  def create
    user = current_user
    lesson_id = params[:lesson_id].to_i
    roster_id = params[:roster_id].to_i unless params[:roster_id].nil?
    
    if roster_id.nil?
      incomplete_quiz = user.last_incomplete_quiz(lesson_id)
    else
      incomplete_quiz = user.last_incomplete_roster_quiz(lesson_id,roster_id)
    end
    @quiz = incomplete_quiz.nil? ? user.quizzes.new(quiz_params) : incomplete_quiz
    
    if @quiz.save
      redirect_to random_question_path(quiz_id: @quiz.id)
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
      # UserMailer.successful_pass_email(@user) if @quiz.pass?
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
  
  def certificate
    @quiz = Quiz.find(params[:quiz_id])
    if @quiz.pass?
      render :certificate
    else
      render text: 'This Quiz is a Fail.'
    end
  end

  private
  def quiz_params
    params.permit(:lesson_id,:roster_id)
  end
end
