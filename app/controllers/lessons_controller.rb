class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find(params[:id])
    @quiz = Quiz.new
  end
end
