class UsersController < ApplicationController
  def dashboard
    @user = current_user
    @quiz = Quiz.new
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
end
