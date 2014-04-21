class UsersController < ApplicationController
  def dashboard
    @user = current_user
    @quiz = Quiz.new
    @lesson = @user.assigned_lesson
    if current_user.admin?
      render :admin_dashboard
    else
      render :user_dashboard
    end
  end
  def summary
    @user = current_user
    if current_user.admin?
      render :admin_summary
    else
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
end
