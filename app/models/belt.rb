class Belt < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :lessons
  
  def max_level
    self.lessons.pluck(:level).max
  end
end