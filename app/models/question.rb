class Question < ActiveRecord::Base
  belongs_to :lesson
  has_many :choices
  validates_presence_of :question
  validates_presence_of :lesson_id

  def answer
    self.choices.where(is_correct: true).first
  end
end
