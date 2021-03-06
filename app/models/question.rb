class Question < ActiveRecord::Base
  belongs_to :lesson
  has_many :choices, :dependent => :destroy, inverse_of: :question
  has_many :answer_submissions, through: :choices
  belongs_to :learning_module
  validates_presence_of :question
  validates_presence_of :lesson_id
  accepts_nested_attributes_for :choices
  has_attached_file :image,
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def answer
    self.choices.where(is_correct: true).first
  end
  
  def total_attempts
    self.answer_submissions.size
  end
  
  def correct_attempts
    self.answer_submissions.select{ |ans| ans.choice.is_correct }.size
  end
  
  def percent_correct
    attempts = self.total_attempts
    attempts == 0 ? nil : self.correct_attempts / self.total_attempts
  end
  
  def random_wrong_choice
    self.choices.where(is_correct: false).first
  end
  
  def s3_credentials
    {:bucket => ENV['BUCKET'], :access_key_id => ENV['ACCESS_KEY_ID'], :secret_access_key => ENV['SECRET_ACCESS_KEY']}
  end
end
