class AddOggVideoToVideos < ActiveRecord::Migration
  def change
    add_attachment :videos, :ogv_video
  end
end
