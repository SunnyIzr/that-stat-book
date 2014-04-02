class Quiz < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  has_many :questions
  has_many :answer_submissions
  validates_presence_of :user_id
  validates_presence_of :lesson_id
  validates_presence_of :time

  def new_random_question
    self.available_questions.sample
  end

  def available_questions
    lesson = self.lesson
    all_questions = Question.where(lesson_id: self.lesson.id)
    all_questions -= self.answered_questions
  end

  def answered_questions
    self.answer_submissions.map {|ans| ans.choice.question}
  end

  def complete?
    self.answer_submissions.size >= 5
  end

  def score
    scores = self.answer_submissions.map { |ans| ans.choice.is_correct ? 1 : 0 }
    scores.inject{ |sum,ans_score| sum + ans_score }.to_f / scores.size
  end

  def pass?
    self.score >= 0.7
  end
end
