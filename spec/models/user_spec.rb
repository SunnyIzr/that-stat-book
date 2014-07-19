require 'spec_helper'

describe User do
  it {should have_many (:quizzes)}
  it {should validate_presence_of (:email)}
  it {should validate_uniqueness_of (:email)}
  let(:total_questions) {ENV['QUIZ_QUESTIONS'].to_i}

  it 'should return all completed quizzes' do
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times {FactoryGirl.create(:question)}
      total_questions.times { |i| FactoryGirl.create(:choice, question_id: Question.all[i].id)}
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: Choice.all[i].id)}
    end
    2.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times {FactoryGirl.create(:question)}
      total_questions.times { |i| FactoryGirl.create(:choice, question_id: Question.all[i].id)}
      total_questions - 1.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: Choice.all[i].id)}
    end

    expect(User.last.completed_quizzes.sort!).to eq(Quiz.all[0..2].sort!)

  end

  it 'should return passed quizzes' do
    total_questions.times {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: Question.all[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: Question.all[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: incorrect_choices[i].id)}
    end
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions - 1.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end

    expect(User.last.passed_quizzes.sort).to eq(Quiz.all[0..2].sort)

  end

  it 'should return completed levels' do
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: incorrect_choices[i].id)}
    end
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions - 1.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end

    expect(User.last.completed_levels).to eq([1,2])
  end

  it 'should return completed lessons' do
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: incorrect_choices[i].id)}
    end
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions - 1.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end

    expect(User.last.completed_lessons.sort).to eq([Lesson.all[0],Lesson.all[1]].sort)
  end

  it 'should return current level' do
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: incorrect_choices[i].id)}
    end
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions - 1.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end

    expect(User.last.level).to eq(3)
  end


  it 'should return first level if no levels have been completed' do
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions - 1.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end

    expect(User.last.level).to eq(1)
  end

  it 'should indicate whether a user has access to a given level' do
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: incorrect_choices[i].id)}
    end
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions - 1.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end

    expect(User.last.access?(3)).to eq(true)
    expect(User.last.access?(total_questions - 1)).to eq(false)
    expect(User.last.access?(1)).to eq(true)
  end

  it 'should return an assigned level based on level completion' do
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end
    FactoryGirl.create(:lesson)
    questions = total_questions.times.map {FactoryGirl.create(:question)}
    correct_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id, is_correct: true)}
    incorrect_choices = total_questions.times.map { |i| FactoryGirl.create(:choice, question_id: questions[i].id)}
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: incorrect_choices[i].id)}
    end
    3.times do
      quiz = FactoryGirl.create(:quiz)
      total_questions - 1.times { |i| FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: correct_choices[i].id)}
    end

    expect(User.last.assigned_lesson).to eq(Lesson.all[2])
  end
  
  it 'should return stringified first and last name' do
    user = FactoryGirl.create(:user, first_name: 'Stats', last_name: 'Ninja')
    
    expect(user.name).to eq('Stats Ninja')
  end
  
  it 'should return all completed quizzes given a specific lesson id' do
    user = FactoryGirl.create(:user)
    3.times do
      FactoryGirl.create(:lesson)
      5.times do 
        FactoryGirl.create(:quiz) 
        total_questions.times do
          FactoryGirl.create(:question)
          FactoryGirl.create(:choice, question_id: Question.last.id)
          FactoryGirl.create(:answer_submission, quiz_id: Quiz.last.id, choice_id: Choice.last.id)
        end
      end
    end
    
    expect(user.completed_quizzes_by_lesson(Lesson.first.id)).to eq(Quiz.all[0..4])
  end
  
  it 'should return the last incomplete quiz given a specific lesson id' do
    user = FactoryGirl.create(:user)
    
    3.times do
      FactoryGirl.create(:lesson)
      6.times do |i|
        unless i == 5 
          FactoryGirl.create(:quiz) 
          total_questions.times do
            FactoryGirl.create(:question)
            FactoryGirl.create(:choice, question_id: Question.last.id)
            FactoryGirl.create(:answer_submission, quiz_id: Quiz.last.id, choice_id: Choice.last.id)
          end
        else
          FactoryGirl.create(:quiz)
          (total_questions-1).times do
            FactoryGirl.create(:question)
            FactoryGirl.create(:choice, question_id: Question.last.id)
            FactoryGirl.create(:answer_submission, quiz_id: Quiz.last.id, choice_id: Choice.last.id)
          end
        end
      end
    end
    expect(user.last_incomplete_quiz(Lesson.all[1].id)).to eq(Quiz.all[11])
  end
  
  it 'should return the average score across all completed quizzes given a specific lesson id' do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:lesson)
    3.times do 
      FactoryGirl.create(:quiz) 
      total_questions.times do
        FactoryGirl.create(:question)
        FactoryGirl.create(:choice, question_id: Question.last.id, is_correct: true)
        FactoryGirl.create(:answer_submission, quiz_id: Quiz.last.id, choice_id: Choice.last.id)
      end
    end
    2.times do 
      FactoryGirl.create(:quiz) 
      total_questions.times do
        FactoryGirl.create(:question)
        FactoryGirl.create(:choice, question_id: Question.last.id)
        FactoryGirl.create(:answer_submission, quiz_id: Quiz.last.id, choice_id: Choice.last.id)
      end
    end
    
    FactoryGirl.create(:lesson)
    5.times do 
      FactoryGirl.create(:quiz) 
      total_questions.times do
        FactoryGirl.create(:question)
        FactoryGirl.create(:choice, question_id: Question.last.id, is_correct: true)
        FactoryGirl.create(:answer_submission, quiz_id: Quiz.last.id, choice_id: Choice.last.id)
      end
    end
    
    FactoryGirl.create(:lesson)
    2.times do
      FactoryGirl.create(:quiz) 
      (total_questions-1).times do
        FactoryGirl.create(:question)
        FactoryGirl.create(:choice, question_id: Question.last.id, is_correct: true)
        FactoryGirl.create(:answer_submission, quiz_id: Quiz.last.id, choice_id: Choice.last.id)
      end
    end
    
    expect(user.avg_score(Lesson.first.id)).to eq(0.6)
    expect(user.avg_score(Lesson.all[1].id)).to eq(1.0)
    expect(user.avg_score(Lesson.last.id)).to eq(0.0)
    
  end
  
  it 'should return ninja status progress' do
    user = FactoryGirl.create(:user)
    3.times do
      FactoryGirl.create(:lesson)
      5.times do 
        FactoryGirl.create(:quiz) 
        total_questions.times do
          FactoryGirl.create(:question)
          FactoryGirl.create(:choice, question_id: Question.last.id, is_correct: true)
          FactoryGirl.create(:answer_submission, quiz_id: Quiz.last.id, choice_id: Choice.last.id)
        end
      end
    end
    2.times do
      FactoryGirl.create(:lesson)
      5.times do 
        FactoryGirl.create(:quiz) 
        total_questions.times do
          FactoryGirl.create(:question)
          FactoryGirl.create(:choice, question_id: Question.last.id)
          FactoryGirl.create(:answer_submission, quiz_id: Quiz.last.id, choice_id: Choice.last.id)
        end
      end
    end
    
    expect(user.ninja_status).to eq(0.6)
    
  end

end
