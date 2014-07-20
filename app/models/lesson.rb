class Lesson < ActiveRecord::Base
  has_many :questions
  has_many :quizzes, :dependent => :destroy
  has_many :videos, :dependent => :destroy
  has_and_belongs_to_many :rosters
  belongs_to :belt
  validates_presence_of :title
  validates_uniqueness_of :level
  validates_presence_of :level
  
  def self.levels
    Lesson.pluck(:level).sort!
  end
  
  def self.create_empty(level)
    max_level = levels.max
    max_level.downto(level) do |x|
      lesson = Lesson.find_by(level: x)
      lesson.level += 1
      lesson.save
    end
  end
  
  def self.fill_empty(level)
    max_level = levels.max
    level += 1
    level.upto(max_level) do |x|
      lesson = Lesson.find_by(level: x)
      lesson.level -= 1
      lesson.save
    end
  end
end
