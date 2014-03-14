class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find(params[:id])
    @quiz = Quiz.new
    if current_user.access?(@lesson.level)
      render :show
    else
      render :restricted
    end
  end
end
