class Quiz < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  belongs_to :roster
  has_many :questions
  has_many :answer_submissions, :dependent => :destroy
  has_many :choices, through: :answer_submissions
  validates_presence_of :user_id
  validates_presence_of :lesson_id
  validates_presence_of :time

  def new_random_question
    self.available_questions.sample
  end

  def available_questions
    lesson = self.lesson
    all_questions = Question.where(lesson_id: self.lesson.id,active: true)
    all_questions -= self.answered_questions
  end

  def answered_questions
    self.answer_submissions.map {|ans| ans.choice.question}
  end
  
  def belt?
    self.roster_id.nil?
  end
  
  def roster?
    !self.roster_id.nil?
  end

  def complete?
    self.answer_submissions.size >= ENV['QUIZ_QUESTIONS'].to_i
  end

  def score
    # scores = self.answer_submissions.map { |ans| ans.choice.is_correct ? 1 : 0 }
    # scores.inject{ |sum,ans_score| sum + ans_score }.to_f / scores.size
    scores = self.choices.pluck(:is_correct).map{|c| c ? 1.0: 0.0}
    scores.sum / scores.size
  end

  def pass?
    self.score >= 0.8
  end
  
  def remaining_questions
    ENV['QUIZ_QUESTIONS'].to_i - self.answer_submissions.size
  end
  
  def add_wrong_submission
    question = self.new_random_question
    wrong_submission = self.answer_submissions.new
    wrong_submission.choice = question.random_wrong_choice
    wrong_submission.save
  end
  
  def finish_incomplete
    self.remaining_questions.times do 
      self.add_wrong_submission
    end
  end
end
