class LearningModulesController < ApplicationController
  def index
    @lesson = Lesson.find(params[:lesson_id])
    @learning_modules = @lesson.learning_modules
    # @learning_module = @lesson.learning_modules.new
    @question = Question.new
  end
  def destroy
     if current_user.admin?
      @lesson = Lesson.find(params[:lesson_id])
      @learning_module = LearningModule.find(params[:id])
      @learning_module.destroy
      redirect_to lesson_learning_modules_path(@lesson)
    end
  end
  def create
    if current_user.admin?
      @lesson = Lesson.find(params[:lesson_id])
      @learning_module = @lesson.learning_modules.new(learning_module_params)
      if @learning_module.save
        redirect_to lesson_learning_modules_path(@lesson)
      else
        render text: 'ERROR'
      end
    end
  end
  def update
    if current_user.admin?
      @learning_module = LearningModule.find(params[:id])
      if @learning_module.update_attributes!(update_learning_module_params)
        respond_to do |format|
          format.json { render json: @learning_module}
        end
      else
        respond_to do |format|
          format.json { render nothing: true }
        end
      end
    end
  end
  
  private
  
  def learning_module_params
    params.require(:learning_module).permit(:title,:description,:lesson_id)
  end
  
  def update_learning_module_params
    params.require(:learning_module).permit(:title,:description)
  end
end