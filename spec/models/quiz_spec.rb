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

  it 'sholuld return a score for a completed quiz' do
    lesson = FactoryGirl.create(:lesson)
    user = FactoryGirl.create(:user)
    quiz = FactoryGirl.create(:quiz, user_id: user.id)
    5.times { FactoryGirl.create(:question, lesson_id: lesson.id)}
    3.times { |i| FactoryGirl.create(:choice, question_id: Question.all[i].id)}
    4.downto(3) { |i| FactoryGirl.create(:choice, question_id: Question.all[i].id, is_correct: true)}
    5.times { |i| FactoryGirl.create(:answer_submission, choice_id: Choice.all[i].id, quiz_id: quiz.id)}

    expect(quiz.score).to eq(0.4)
  end

  it 'sholuld determine whether a quiz has passed or failed' do
    lesson = FactoryGirl.create(:lesson)
    user = FactoryGirl.create(:user)
    quiz_1 = FactoryGirl.create(:quiz, user_id: user.id)
    quiz_2 = FactoryGirl.create(:quiz, user_id: user.id)
    5.times { FactoryGirl.create(:question, lesson_id: lesson.id)}
    1.times { |i| FactoryGirl.create(:choice, question_id: Question.all[i].id)}
    4.downto(1) { |i| FactoryGirl.create(:choice, question_id: Question.all[i].id, is_correct: true)}
    5.times { |i| FactoryGirl.create(:answer_submission, choice_id: Choice.all[i].id, quiz_id: quiz_1.id)}
    3.times { |i| FactoryGirl.create(:answer_submission, choice_id: Choice.all[i].id, quiz_id: quiz_2.id)}

    expect(quiz_1.pass?).to eq(true)
    expect(quiz_2.pass?).to eq(false)
  end

  it 'should return a new random question' do
    user = FactoryGirl.create(:user)
    100.times do
      lesson = FactoryGirl.create(:lesson)
      5.times { lesson.questions << FactoryGirl.create(:question,:lesson_id => lesson.id)}
      3.times { FactoryGirl.create(:quiz,:lesson_id => lesson.id, :user_id => user.id)}
    end
    quiz = Quiz.all.sample
    expect(quiz.new_random_question.class).to eq(Question)
    expect(quiz.new_random_question.lesson).to eq(quiz.lesson)

  end

  it 'should return a list of available questions that does NOT include questions that have been answered' do
    user = FactoryGirl.create(:user)
    10.times do
      lesson = FactoryGirl.create(:lesson)
      10.times { lesson.questions << FactoryGirl.create(:question,:lesson_id => lesson.id)}
      lesson.questions.each { |question| 5.times { question.choices << FactoryGirl.create(:choice, :question_id => question.id) } }
      quiz = FactoryGirl.create(:quiz, :lesson_id => lesson.id, :user_id => User.last.id)
      3.times { |i| FactoryGirl.create(:answer_submission,:choice_id => lesson.questions[i].choices.sample.id, :quiz_id => quiz.id)}
    end

    quiz = Lesson.first.quizzes.first

    expect(quiz.available_questions).not_to include(quiz.answered_questions[0])
    expect(quiz.available_questions).not_to include(quiz.answered_questions[1])
    expect(quiz.available_questions).not_to include(quiz.answered_questions[2])
  end
end
