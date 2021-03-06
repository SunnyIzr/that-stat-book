class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    @total_questions = ENV['QUIZ_QUESTIONS']
    unless current_user.student?
      @user = current_user
      respond_to do |format|
        format.html {render :show_admin}
        format.json {render :json => @question}
      end
    else
      @choices = @question.choices.shuffle
      @ids = %w[A B C D]
      @quiz = Quiz.find(params[:quiz_id])
      @answer_submission = AnswerSubmission.new
    end
  end
  def show_random_question
    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.new_random_question
    redirect_to question_path(id: @question.id, quiz_id: @quiz.id)
  end
  
  def new
    if current_user.admin?
      @lesson = Lesson.find(params[:lesson_id])
      @question = @lesson.questions.new
      4.times { @question.choices.build }
    end
  end
  
  def create
    if current_user.admin?
      @question = Question.new(question_params)
      @question.choices.first.is_correct = true    
      if @question.save
        redirect_to question_path(@question)
      else
        render text: 'ERROR'
      end
    end
  end
  
  def destroy
    if current_user.admin?
      @question = Question.find(params[:id])
      @lesson = @question.lesson
      @question.active = false
      @question.save
      redirect_to lesson_path(@lesson)
    end
  end
  
  def update
    if current_user.admin?
      @question = Question.find(params[:id])
      if @question.update_attributes!(update_question_params)
        respond_to do |format|
          format.html { redirect_to( @question )}
          format.json { render :json => @question }
        end
      end
    end
  end
  
  def update_learning_module
    if current_user.admin?
      @question = Question.find(params[:id])
      @learning_module = LearningModule.find(params[:learning_module_id])
      @question.update!(learning_module: @learning_module)
      redirect_to lesson_path(@question.lesson)
    end
  end
  
  def delete_image
    @question = Question.find(params[:id])
    @question.image = nil
    @question.save
    redirect_to question_path(@question)
  end
  
  private
  def question_params
    params.require(:question).permit(:question,:image,:lesson_id,choices_attributes:[:choice])
  end
  def update_question_params
    params.require(:question).permit(:question,:image)
  end
end
