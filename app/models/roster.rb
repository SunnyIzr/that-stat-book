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
    if self.quiz_attempts.empty?
      0
    else
      self.quiz_attempts.map{|quiz| quiz.score}.sum / self.quiz_attempts.size
    end
  end
  
  def view_count
    users = self.users
    users.map { |user| user.roster_view_count(self)}.sum
  end
end