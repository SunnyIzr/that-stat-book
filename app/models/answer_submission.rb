class AnswerSubmission < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :choice
  has_one :question, through: :choice
  has_one :learning_module, through: :question
  validates_presence_of :quiz_id
  validates_presence_of :choice_id
  validate :question_cannot_be_answered_twice

  def question_cannot_be_answered_twice
    question = self.choice.question
    questions_answered = self.quiz.answered_questions
    if questions_answered.include?(question)
      errors.add(:choice, 'Question has aready been answered in this Quiz.')
    end
  end

end
