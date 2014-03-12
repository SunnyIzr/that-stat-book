require 'spec_helper'

describe Question do
  it {should have_many (:choices)}
  it {should belong_to (:lesson)}
  it {should validate_presence_of (:question)}
  it {should validate_presence_of (:lesson_id)}

  it 'should return a random question for a specified lesson' do
    user = FactoryGirl.create(:user)
    100.times do
      lesson = FactoryGirl.create(:lesson)
      5.times { lesson.questions << FactoryGirl.create(:question,:lesson_id => lesson.id)}
      3.times { FactoryGirl.create(:quiz,:lesson_id => lesson.id, :user_id => user.id)}
    end
    quiz = Quiz.all.sample
    expect(Question.random(quiz.id).class).to eq(Question)
    expect(Question.random(quiz.id).lesson).to eq(quiz.lesson)

  end

  it 'should return a list of available questions for a specified lesson that does NOT include questions that have been answered' do
    user = FactoryGirl.create(:user)
    10.times do
      lesson = FactoryGirl.create(:lesson)
      10.times { lesson.questions << FactoryGirl.create(:question,:lesson_id => lesson.id)}
      lesson.questions.each { |question| 5.times { question.choices << FactoryGirl.create(:choice, :question_id => question.id) } }
      quiz = FactoryGirl.create(:quiz, :lesson_id => lesson.id, :user_id => User.last.id)
      3.times { |i| FactoryGirl.create(:answer_submission,:choice_id => lesson.questions[i].choices.sample.id, :quiz_id => quiz.id)}
    end

    expect(Question.available_questions(Lesson.first.quizzes.first.id)).not_to include(Lesson.first.quizzes.first.answered_questions[0])
    expect(Question.available_questions(Lesson.first.quizzes.first.id)).not_to include(Lesson.first.quizzes.first.answered_questions[1])
    expect(Question.available_questions(Lesson.first.quizzes.first.id)).not_to include(Lesson.first.quizzes.first.answered_questions[2])


  end
end
