class Roster < ActiveRecord::Base
  belongs_to :professor
  has_and_belongs_to_many :users
  has_and_belongs_to_many :lessons
  
  def quiz_attempts
    
  end
  
  def avg_score
  end
  
  def view_count
  end
end