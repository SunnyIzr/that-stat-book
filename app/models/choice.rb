class Choice < ActiveRecord::Base
  belongs_to :question, inverse_of: :choices
  has_many :answer_submissions
  validates_presence_of :choice
  validates_presence_of :question

end
