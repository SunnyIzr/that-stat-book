class User < ActiveRecord::Base
  has_many :quizzes
  validates_presence_of :email
  validates_uniqueness_of :email


end
