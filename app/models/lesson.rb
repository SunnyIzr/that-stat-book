class Lesson < ActiveRecord::Base
  has_many :questions
  has_many :quizzes
end
