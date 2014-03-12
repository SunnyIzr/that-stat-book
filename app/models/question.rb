class Question < ActiveRecord::Base
  belongs_to :lesson
  has_many :choices
  validates_presence_of :question
  validates_presence_of :lesson_id

  def self.random(lesson_id,quiz_id=nil)
    questions = self.where(lesson_id: lesson_id)
    questions.sample
  end
end
