class VideoViewsController < ApplicationController
  def create
    @video_view = VideoView.new(video_view_params)
    if @video_view.save
      respond_to do |format|
        msg = { :status => "ok", :message => "Success!" }
        format.json  { render :json => msg }
      end
    end
  end
  
  private
  def video_view_params
    params.permit(:user_id,:video_id)
  end
end