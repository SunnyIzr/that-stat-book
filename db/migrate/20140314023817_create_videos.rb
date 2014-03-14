class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.attachment :video
      t.belongs_to :lesson
      t.timestamps
    end
  end
end
