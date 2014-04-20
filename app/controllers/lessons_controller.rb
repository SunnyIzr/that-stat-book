class LessonsController < ApplicationController
  def show
    if current_user.admin?
      @lesson = Lesson.find(params[:id])
      @questions = @lesson.questions
      render :show
    else
      render text: 'Restricted'
    end
  end
  
  def index
    if current_user.admin?
      @lessons = Lesson.all
      render :index
    else
      render text: 'Restricted'
    end
  end
end
