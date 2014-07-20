class Roster < ActiveRecord::Base
  belongs_to :professor
  has_and_belongs_to_many :users
  has_and_belongs_to_many :lessons
  
  def quiz_attempts
    total_quiz_attempts = []
    self.lessons.each do |lesson|
      self.users.each do |user|
        total_quiz_attempts << user.quiz_attempts(lesson.id)
      end
    end
    total_quiz_attempts.flatten
  end
  
  def avg_score
    self.quiz_attempts.map{|quiz| quiz.score}.sum / self.quiz_attempts.size
  end
  
  def view_count
  end
end