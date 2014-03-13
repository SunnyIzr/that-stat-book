require 'spec_helper'

describe User do
  it {should have_many (:quizzes)}
  it {should validate_presence_of (:email)}
  it {should validate_uniqueness_of (:email)}

  it 'should return all completed quizzes' do
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times {FactoryGirl.create(:question)}
      5.times { |i| FactoryGirl.create(:choice, question_id: Question.all[i].id)}
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: Choice.all[i].id)}
    end
    2.times do
      quiz = FactoryGirl.create(:quiz)
      5.times {FactoryGirl.create(:question)}
      5.times { |i| FactoryGirl.create(:choice, question_id: Question.all[i].id)}
      4.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: Choice.all[i].id)}
    end

    expect(User.last.completed_quizzes).to eq(Quiz.all[0..2])

  end

end
