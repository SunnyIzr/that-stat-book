class PagesController < ApplicationController
  def welcome
    if current_user.present?
      redirect_to user_dashboard_path
    end
  end
  def password_reset
  end
end
