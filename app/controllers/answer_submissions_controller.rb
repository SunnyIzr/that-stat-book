class AnswerSubmissionsController < ApplicationController
  def create
    @answer_submission = AnswerSubmission.new(answer_submission_params)
    if @answer_submission.save
      redirect_to ("/quizzes/#{params[:quiz_id]}/new-question")
    else
      render text: 'FAIL!'
    end
  end

  private
  def answer_submission_params
    params.permit(:quiz_id,:choice_id)
  end
end
