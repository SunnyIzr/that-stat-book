class LearningModule < ActiveRecord::Base
  has_many :questions
  belongs_to :lesson
  
  def index
  end
end