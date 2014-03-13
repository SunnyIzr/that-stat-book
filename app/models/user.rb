class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :quizzes
  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false

  def completed_quizzes
    self.quizzes.select {|quiz| quiz.complete?}
  end

  def passed_quizzes
    self.completed_quizzes.select {|quiz| quiz.pass?}
  end

  def completed_levels
    completed_levels = []
    self.passed_quizzes.each {|quiz| completed_levels |= [quiz.lesson.level]}
    completed_levels
  end

  def level
    self.completed_levels.max + 1
  end

  def access?(level)
    accessible = self.completed_levels
    accessible << self.level
    accessible.include?(level)
  end

end
