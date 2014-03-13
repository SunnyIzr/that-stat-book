require 'spec_helper'

describe Question do
  it {should have_many (:choices)}
  it {should belong_to (:lesson)}
  it {should validate_presence_of (:question)}
  it {should validate_presence_of (:lesson_id)}

  it 'should return the answer' do
    question = FactoryGirl.create(:question)
    3.times { FactoryGirl.create(:choice, question_id: question.id) }
    answer = FactoryGirl.create(:choice, question_id: question.id, is_correct: true)

    expect(question.answer).to eq(answer)
  end
end
