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

  it 'should return passed quizzes' do
    5.times {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: Question.all[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: Question.all[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: incorrect_choices[i].id)}
    end
    3.times do
      quiz = FactoryGirl.create(:quiz)
      4.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end

    expect(User.last.passed_quizzes).to eq(Quiz.all[0..2])

  end

  it 'should return completed levels' do
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: incorrect_choices[i].id)}
    end
    3.times do
      quiz = FactoryGirl.create(:quiz)
      4.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end

    expect(User.last.completed_levels).to eq([1,2])
  end

  it 'should return completed lessons' do
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: incorrect_choices[i].id)}
    end
    3.times do
      quiz = FactoryGirl.create(:quiz)
      4.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end

    expect(User.last.completed_lessons).to eq([Lesson.all[0],Lesson.all[1]])
  end

  it 'should return current level' do
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: incorrect_choices[i].id)}
    end
    3.times do
      quiz = FactoryGirl.create(:quiz)
      4.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end

    expect(User.last.level).to eq(3)
  end


  it 'should return first level if no levels have been completed' do
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      4.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end

    expect(User.last.level).to eq(1)
  end

  it 'should indicate whether a user has access to a given level' do
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: incorrect_choices[i].id)}
    end
    3.times do
      quiz = FactoryGirl.create(:quiz)
      4.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end

    expect(User.last.access?(3)).to eq(true)
    expect(User.last.access?(4)).to eq(false)
    expect(User.last.access?(1)).to eq(true)
  end

  it 'should return an assigned level based on level completion' do
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = 5.times.map {FactoryGirl.create(:question)}
    correct_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = 5.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      5.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: incorrect_choices[i].id)}
    end
    3.times do
      quiz = FactoryGirl.create(:quiz)
      4.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end

    expect(User.last.assigned_lesson).to eq(Lesson.all[2])
  end

end
