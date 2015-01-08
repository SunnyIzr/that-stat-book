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
    @user = current_user
    @lesson = @quiz.lesson
    @incorrect_answers = @quiz.answer_submissions.select{ |ans| !ans.choice.is_correct? }
    if @user.student?
    @new_quiz = Quiz.new
      if @quiz.complete?
        @user.update_belts
        UserMailer.completed_quiz_email(@user,@quiz)
        render :show
      else
        render :incomplete
      end
    else
      @student = @quiz.user
      @lesson = @quiz.lesson
      @answers = @quiz.answer_submissions.sort_by{|as| as.choice.is_correct?.to_s }
      render :show_professor
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
  
  def feedback
    @user = current_user
    @quiz = Quiz.find(params[:id])
    @lesson = @quiz.lesson
    @incorrect_answers = @quiz.answer_submissions.select{ |ans| !ans.choice.is_correct? }
  end

  private
  def quiz_params
    params.permit(:lesson_id,:roster_id)
  end
end
