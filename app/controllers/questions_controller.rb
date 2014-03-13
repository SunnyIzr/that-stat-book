class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    @answer_submission = AnswerSubmission.new
  end
end
