class Video < ActiveRecord::Base
  belongs_to :lesson
  has_attached_file :video, styles: { original: "4000x4000>", small: "200x200>", thumb: "100x100>" }
end
