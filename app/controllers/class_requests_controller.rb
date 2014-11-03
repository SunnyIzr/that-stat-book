class ClassRequestsController < ApplicationController
  def create
    roster = Roster.find(params[:roster])
    @class_request = ClassRequest.create(user: current_user, roster: roster)
    UserMailer.new_student_request(@class_request)
    redirect_to rosters_path
  end
  
  def index
    if current_user.type == 'Professor' 
      @class_requests = current_user.class_requests.select{ |cr| !cr.accepted }
    end
  end
  
  def accept
    if current_user.type == 'Professor' 
      @class_request = ClassRequest.find(params[:id])
      @class_request.accept!
      redirect_to class_requests_path
    end
  end
  
  def reject
    if current_user.type == 'Professor' 
      @class_request = ClassRequest.find(params[:id])
      @class_request.destroy
      redirect_to class_requests_path
    end
  end
  
  private
  
  def class_request_params
    params.permit(:roster)
  end
end