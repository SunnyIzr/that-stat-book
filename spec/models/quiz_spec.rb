require 'spec_helper'

describe Quiz do
  it {should belong_to (:user)}
  it {should belong_to (:lesson)}
  it {should have_many (:answer_submissions)}
  it {should validate_presence_of (:user_id)}
  it {should validate_presence_of (:lesson_id)}

  it 'should return a list of all questions answered' do
    FactoryGirl.create(:quiz)
    10.times do
      FactoryGirl.create(:question, :lesson_id => Lesson.last.id)
      FactoryGirl.create(:choice, :question_id => Question.last.id)
      FactoryGirl.create(:answer_submission, :choice_id => Choice.last.id, :quiz_id => Quiz.last.id)
    end
    FactoryGirl.create(:quiz, :lesson_id => Lesson.last.id, :user_id => User.last.id)
    10.times do
      FactoryGirl.create(:question, :lesson_id => Lesson.last.id)
      FactoryGirl.create(:choice, :question_id => Question.last.id)
      FactoryGirl.create(:answer_submission, :choice_id => Choice.last.id, :quiz_id => Quiz.last.id)
    end
    expect(Quiz.first.answered_questions).to eq(Question.all[0..9])
  end
end
