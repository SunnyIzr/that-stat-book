class AnswerSubmission < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :choice
  validates_presence_of :quiz_id
  validates_presence_of :choice_id

end
