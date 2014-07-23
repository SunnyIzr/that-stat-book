class AnswerSubmissionsController < ApplicationController
  def create
    @answer_submission = AnswerSubmission.new(answer_submission_params)
    @quiz = Quiz.find(params[:quiz_id])
    if @answer_submission.save
      unless @quiz.complete?
        redirect_to random_question_path(quiz_id: @quiz.id)
      else
        redirect_to quiz_path(@quiz)
      end
    end
  end

  private
  def answer_submission_params
    params.permit(:quiz_id,:choice_id)
  end
end
