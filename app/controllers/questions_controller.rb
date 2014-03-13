class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    @answer_submission = AnswerSubmission.new
  end
  def show_random_question
    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.new_random_question
    redirect_to question_path(@question)
  end
end
