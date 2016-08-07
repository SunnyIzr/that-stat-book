class Roster < ActiveRecord::Base
  belongs_to :professor
  has_and_belongs_to_many :users
  has_and_belongs_to_many :lessons
  has_many :quizzes, through: :users
  has_many :video_views, through: :users
  has_many :class_requests
  
  def quiz_attempts
    # total_quiz_attempts = []
    # self.lessons.each do |lesson|
    #   self.users.each do |user|
    #     total_quiz_attempts << user.quiz_attempts(lesson.id)
    #   end
    # end
    # total_quiz_attempts.flatten
    
    # Pulls completed quizzes on all users associated with current roster INCL lessons no longer in the roster
    
    self.quizzes.select("quizzes.*").joins(:answer_submissions).group("quizzes.id").having("count(answer_submissions.id) >= ?", 20).to_a
  end
  
  def avg_score
    q_attempts = self.quiz_attempts.clone
    if q_attempts.empty?
      0
    else
      q_attempts.map{|quiz| quiz.score}.sum / q_attempts.size
    end
  end
  
  def view_count
    users = self.users
    users.map { |user| user.roster_view_count(self)}.sum
  end
  
  def stats
    attempts = self.quiz_attempts
    {
      quiz_attempts: attempts.size,
      avg_score: attempts.empty? ? 0 : attempts.map{|quiz| quiz.score}.sum / attempts.size,
      view_count: self.video_views.size
    }
  end
  
  def stats_detailed
    
    
  end
  
  
  
  
  
  
  
end