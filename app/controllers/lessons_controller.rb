class LessonsController < ApplicationController
  def show
    unless current_user.student?
      @user = current_user
      @lesson = Lesson.find(params[:id])
      @learning_module = @lesson.learning_modules.new
      @learning_modules = @lesson.learning_modules
      @questions = @lesson.questions.select { |q| q.active == true }
      respond_to do |format|
        format.html {render :show}
        format.json {render :json => @lesson}
      end
    else
      render text: 'Restricted'
    end
  end
  
  def index
    if current_user.admin?
      @lessons = Lesson.all.sort_by { |lesson| lesson.level }
      render :index
    else
      render text: 'Restricted'
    end
  end
  
  def update
    if current_user.admin?
      @lesson = Lesson.find(params[:id])
      if @lesson.update_attributes!(update_lesson_params)
        respond_to do |format|
          format.json { render :json => @lesson }
        end
      else
        respond_to do |format|
          format.html { render :action  => :edit } # edit.html.erb
          format.json { render :nothing =>  true }
        end
      end
    end
  end
  
  def destroy
    if current_user.admin?
      @lesson = Lesson.find(params[:id])
      destroyed_level = @lesson.level
      @lesson.destroy
      Lesson.fill_empty(destroyed_level)
      redirect_to lessons_path
    end
  end
  
  def new
    if current_user.admin?
     @lesson = Lesson.new 
    end
  end
  
  def create
    if current_user.admin?
      @lesson = Lesson.new(lesson_params)
      belt_max_level = @lesson.belt.max_level
      Lesson.create_empty(belt_max_level)
      @lesson.level = belt_max_level
      if @lesson.save
        redirect_to lesson_path(@lesson)
      else
        render text: 'ERROR'
      end
    end
  end
  
  def rearrange
    @belt_lessons = Belt.sorted_lessons
  end
  
  def sort
    new_levels = params[:lesson].keys
    new_levels.each_with_index do |id, index|
      new_level = index + 1
      Lesson.update_all({level: new_level, belt_id: Belt.find_by(belt: params[:lesson][id.to_s]).id},{id: id})
    end
    render nothing: true
  end
  
  private

  def lesson_params
    params.require(:lesson).permit(:title,:belt_id)
  end
  def update_lesson_params
    params.require(:lesson).permit(:title)
  end
end
