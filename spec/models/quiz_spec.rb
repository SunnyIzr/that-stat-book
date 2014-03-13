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

  it 'sholuld identify if a quiz is complete based on 5 answer submissions' do
    lesson = FactoryGirl.create(:lesson)
    user = FactoryGirl.create(:user)
    quiz_1 = FactoryGirl.create(:quiz, user_id: user.id)
    quiz_2 = FactoryGirl.create(:quiz, user_id: user.id)
    5.times { FactoryGirl.create(:question, lesson_id: lesson.id)}
    5.times { |i| FactoryGirl.create(:choice, question_id: Question.all[i].id)}
    5.times { |i| FactoryGirl.create(:answer_submission, choice_id: Choice.all[i].id, quiz_id: quiz_1.id)}
    4.times { |i| FactoryGirl.create(:answer_submission, choice_id: Choice.all[i].id, quiz_id: quiz_2.id)}

    expect(quiz_1.complete?).to eq(true)
    expect(quiz_2.complete?).to eq(false)
  end
end
