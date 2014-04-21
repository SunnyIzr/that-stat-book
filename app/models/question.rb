class Question < ActiveRecord::Base
  belongs_to :lesson
  has_many :choices, :dependent => :destroy, inverse_of: :question
  validates_presence_of :question
  validates_presence_of :lesson_id
  accepts_nested_attributes_for :choices
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def answer
    self.choices.where(is_correct: true).first
  end
  
  def random_wrong_choice
    self.choices.where(is_correct: false).first
  end
end
