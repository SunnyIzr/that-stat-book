class Quiz < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  has_many :questions
  has_many :answer_submissions
  validates_presence_of :user_id
  validates_presence_of :lesson_id

end
