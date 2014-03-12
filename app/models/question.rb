class Question < ActiveRecord::Base
  belongs_to :lesson
  has_many :choices
  validates_presence_of :question
  validates_presence_of :lesson_id

  def self.random(quiz_id)
    self.available_questions(quiz_id).sample
  end

  def self.available_questions(quiz_id)
    quiz = Quiz.find(quiz_id)
    lesson = quiz.lesson
    all_questions = self.where(lesson_id: lesson.id)
    all_questions -= Quiz.find(quiz_id).answered_questions
  end
end
