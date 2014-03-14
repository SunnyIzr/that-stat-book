class AnswerSubmissionsController < ApplicationController
  def create
    @answer_submission = AnswerSubmission.new(answer_submission_params)
    @quiz = Quiz.find(params[:quiz_id])
    if @answer_submission.save
      unless @quiz.complete?
        redirect_to ("/quizzes/#{@quiz.id}/new-question")
      else
        redirect_to quiz_path(@quiz)
      end
    else
      render text: 'FAIL!'
    end
  end

  private
  def answer_submission_params
    params.permit(:quiz_id,:choice_id)
  end
end
