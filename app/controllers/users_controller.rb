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
      @users = User.all.select{|user| user.student?}.sort_by{ |user| user.list_name}
    end
  end
  def professors_index
    if current_user.admin?
      @professors = User.all.select{|user| user.type == 'Professor' }.sort_by{ |user| user.list_name}
    end
  end
  def show
    if current_user.admin?
      @user = User.find(params[:id])
      unless @user.student?
        @rosters = @user.rosters
        render :show_professor
      end
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
