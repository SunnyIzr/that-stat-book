class UsersController < ApplicationController
  def dashboard
    @user = current_user
    if current_user.admin?
      render :admin_dashboard
    else
      render :user_dashboard
    end
  end
end
