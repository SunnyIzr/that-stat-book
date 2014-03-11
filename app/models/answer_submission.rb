class AnswerSubmission < ActiveRecord::Base
belongs_to :quiz
belongs_to :choice

end
