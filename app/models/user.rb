class User < ActiveRecord::Base
  has_and_belongs_to_many :belts, uniq: true
  belongs_to :school
  has_and_belongs_to_many :rosters
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :quizzes, :dependent => :destroy
  has_many :video_views, :dependent => :destroy
  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false
  self.inheritance_column = :type

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

  def update_belts
    unless self.completed_lessons.empty?
      belt = self.completed_lessons.last.belt
      lessons = belt.lessons
      passes = lessons.map { |lesson| self.completed_lessons.include?(lesson) }
      self.belts << belt unless passes.include?(false)
      self.belts.uniq!
      self.save
    end
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

  def ninja_status
    self.completed_lessons.size.to_f / Lesson.all.size
  end
  
  
  #Lesson Level Stats
  
  def quiz_attempts(lesson_id)
    self.completed_quizzes.select { |quiz| quiz.lesson_id == lesson_id }
  end
  
  def avg_score(lesson_id)
    lesson_quizzes = self.quiz_attempts(lesson_id)
    if lesson_quizzes.empty?
      0
    else
      sum = lesson_quizzes.map { |quiz| quiz.score }.sum
      sum / lesson_quizzes.size
    end
  end
    
  def view_count(lesson_id)
    lesson = Lesson.find(lesson_id)
    if lesson.videos.empty?
      0
    else
      video_id = lesson.videos.first.id
      self.video_views.where(video_id: video_id).size
    end
  end
  
  #Roster-Level Stats
  
  def roster_quiz_attempts(roster)
    lessons = roster.lessons
    lessons.map{ |lesson| self.quiz_attempts(lesson.id)}.flatten
  end
  
  def roster_avg_score(roster)
    self.roster_quiz_attempts(roster).map{|quiz| quiz.score}.sum / self.roster_quiz_attempts(roster).size
  end

end
