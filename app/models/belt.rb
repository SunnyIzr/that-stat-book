class Belt < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :lessons
  
  def max_level
    self.lessons.pluck(:level).max
  end
  
  def self.sorted_lessons
    data = {}
    all.each do |belt|
      data[belt] = belt.lessons.sort_by { |lesson| lesson.level }
    end
    data
  end
end