require 'spec_helper'

describe AnswerSubmission do
  it {should belong_to (:quiz)}
  it {should belong_to (:choice)}
  it 'should ensure that a question is only answered once on a quiz' do
    answer_submission_1 = FactoryGirl.create(:answer_submission)
    choice_2 = FactoryGirl.create(:choice, question_id: Question.last.id)
    answer_submission_2 = FactoryGirl.build(:answer_submission, quiz_id: Quiz.last.id, choice_id: choice_2.id)
    expect(answer_submission_2.valid?).to eq(false)
  end
end
