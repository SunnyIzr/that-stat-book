class CreateVideoViews < ActiveRecord::Migration
  def change
    create_table :video_views do |t|
      t.belongs_to :user
      t.belongs_to :video
      t.timestamps
    end
  end
end
