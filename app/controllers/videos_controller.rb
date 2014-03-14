class VideosController < ApplicationController
  def new
    @video = Video.new
  end

  def create
    @video = Video.new( video_params )
    @video.save
  end

  private

# Use strong_parameters for attribute whitelisting
# Be sure to update your create() and update() controller methods.

  def video_params
    params.permit(:video)
  end
end
