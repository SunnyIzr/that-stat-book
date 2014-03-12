class AnswerSubmission < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :choice
  validates_presence_of :quiz_id
  validates_presence_of :choice_id
  validate :question_cannot_be_answered_twice

  def question_cannot_be_answered_twice
    question = self.choice.question
    questions_answered = self.quiz.answer_submissions.map { |ans| ans.choice.question }
    if questions_answered.include?(question)
      errors.add(:choice, 'Question has aready been answered in this Quiz.')
    end
  end

end
