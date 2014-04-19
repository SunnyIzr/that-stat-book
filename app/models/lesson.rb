class Lesson < ActiveRecord::Base
  has_many :questions
  has_many :quizzes
  has_many :videos
  belongs_to :belt
  validates_presence_of :title
  validates_uniqueness_of :level
  validates_presence_of :level
end
