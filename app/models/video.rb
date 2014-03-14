class Video < ActiveRecord::Base
  belongs_to :lesson
  has_attached_file :video, styles: { original: "4000x4000>", large: "1500x1500>", medium: "300x300>", small: "200x200>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
end
