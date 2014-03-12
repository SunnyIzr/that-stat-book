class Question < ActiveRecord::Base
  belongs_to :lesson
  has_many :choices
  validates_presence_of :question
  validates_presence_of :lesson_id

  def self.random(lesson_id,quiz_id=nil)
    self.available_questions(lesson_id,quiz_id).sample
  end

  def self.available_questions(lesson_id,quiz_id)
    all_questions = self.where(lesson_id: lesson_id)
    unless quiz_id.nil?
      all_questions -= Quiz.find(quiz_id).answered_questions
    end
    all_questions
  end
end
