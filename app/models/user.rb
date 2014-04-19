class User < ActiveRecord::Base
  has_and_belongs_to_many :belts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :quizzes
  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false

  def name
    self.first_name + ' ' + self.last_name
  end

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

  def completed_lessons
    completed_lessons = []
    self.passed_quizzes.each {|quiz| completed_lessons |= [quiz.lesson]}
    completed_lessons
  end

  def level
    self.completed_levels.max.to_i + 1
  end

  def access?(level)
    accessible = self.completed_levels
    accessible << self.level
    accessible.include?(level)
  end

  def assigned_lesson
    Lesson.find_by(level: self.level)
  end
  
  def last_incomplete_quiz(lesson_id)
    quizzes_for_lesson = self.quizzes.select { |quiz| quiz.lesson_id == lesson_id }
    incomplete_quizzes = quizzes_for_lesson.select {|quiz| !quiz.complete?}
    incomplete_quizzes.last
  end
  
  def update_belts
    unless self.completed_lessons.empty?
      belt = self.completed_lessons.last.belt
      lessons = belt.lessons
      passes = lessons.map { |lesson| self.completed_lessons.include?(lesson) }
      self.belts << belt unless passes.include?(false)
      self.save
    end
  end

end
