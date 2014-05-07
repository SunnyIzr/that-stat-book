class VideosController < ApplicationController
  def new
    @lesson = Lesson.find(params[:lesson_id])
    @video = Video.new
    @html = {html: render_to_string(partial: 'new')}
    render json: @html
  end

  def create
    @video = Video.new( video_params )
    @lesson = @video.lesson
    @first_video = @lesson.videos.first
    @first_video.destroy unless @first_video.nil?
    if @video.save
      redirect_to lesson_path(@lesson)
    end
  end

  private

# Use strong_parameters for attribute whitelisting
# Be sure to update your create() and update() controller methods.

  def video_params
    params.require(:video).permit(:video,:ogv_video,:lesson_id)
  end
end
