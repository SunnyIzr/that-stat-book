class UsersController < ApplicationController
  def dashboard
    @user = current_user
    @quiz = Quiz.new
    @lesson = @user.assigned_lesson
    if current_user.admin?
      redirect_to lessons_path
    elsif current_user.student?
      render :user_dashboard
    elsif current_user.class == Professor
      redirect_to rosters_path 
    end
  end
  def summary
    @user = current_user
    if @user.student?
      @lessons = @user.completed_lessons
      @lessons << @user.assigned_lesson
      @quiz = Quiz.new
      render :summary
    end
  end
  def index
    if current_user.admin?
      @users = User.all
    end
  end
  def show
    if current_user.admin?
      @user = User.find(params[:id])
    end
  end
  def destroy
    if current_user.admin?
      @user = User.find(params[:id])
      @user.destroy
      redirect_to users_path
    end
  end
end
