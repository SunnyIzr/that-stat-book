class ClassRequestsController < ApplicationController
  def create
    roster = Roster.find(params[:roster])
    ClassRequest.create(user: current_user, roster: roster)
    redirect_to rosters_path
  end
  
  private
  
  def class_request_params
    params.permit(:roster)
  end
end