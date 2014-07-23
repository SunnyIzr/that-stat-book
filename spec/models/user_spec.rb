require 'spec_helper'

describe User do
  let(:total_questions) {ENV['QUIZ_QUESTIONS'].to_i}
  
  it {should have_many (:quizzes)}
  it {should validate_presence_of (:email)}
  it {should validate_uniqueness_of (:email)}
  it {should have_and_belong_to_many(:rosters)}
  it {should have_and_belong_to_many(:belts)}

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

    expect(User.last.completed_quizzes).to match_array(Quiz.all[0..2])

  end
  
  it 'should indicate if user is a student' do
    admin = FactoryGirl.create(:user, email: 'admin@gmail.com', admin: true)
    prof = FactoryGirl.create(:user, email: 'prof@prof.com', type: 'Professor')
    user = FactoryGirl.create(:user)
    
    expect(admin.student?).to eq(false)
    expect(prof.student?).to eq(false)
    expect(user.student?).to eq(true)
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

    expect(User.last.passed_quizzes).to match_array(Quiz.all[0..2])

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

    expect(User.last.completed_lessons).to match_array([Lesson.all[0],Lesson.all[1]])
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
  
  it 'should return stringified last name, first name' do
    user = FactoryGirl.create(:user, first_name: 'Stats', last_name: 'Ninja')
    
    expect(user.list_name).to eq('Ninja, Stats')
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
    
    expect(user.quiz_attempts(Lesson.first.id)).to match_array(Quiz.all[0..4])
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
  
  it 'should generate all quiz attempts for the lessons on a given roster' do
    user = FactoryGirl.create(:user)
    10.times do
      FactoryGirl.create(:lesson)
      (total_questions*3).times do 
        FactoryGirl.create(:question)
        FactoryGirl.create(:choice, question_id: Question.last.id)
      end
      3.times do 
        FactoryGirl.create(:quiz)
        Quiz.last.finish_incomplete
      end
    end
    roster = FactoryGirl.create(:roster)
    roster.lessons << Lesson.all[0..3]
    expect(user.roster_quiz_attempts(roster)).to match_array(Quiz.all[0..11])
  end
  
  it 'should calculate average score across on quiz attempts for the lessons on a given roster' do
    user = FactoryGirl.create(:user)
    3.times do
      FactoryGirl.create(:lesson)
      (total_questions*3).times do 
        FactoryGirl.create(:question)
        FactoryGirl.create(:choice, question_id: Question.last.id, is_correct: true)
      end
      3.times do 
        FactoryGirl.create(:quiz)
        total_questions.times do |i|
          questions = Question.where(lesson_id: Lesson.last.id)
          FactoryGirl.create(:answer_submission, quiz_id: Quiz.last.id, choice_id: questions[i].choices.first.id)
        end
      end
    end
    7.times do
      FactoryGirl.create(:lesson)
      (total_questions*3).times do 
        FactoryGirl.create(:question)
        FactoryGirl.create(:choice, question_id: Question.last.id)
      end
      3.times do 
        FactoryGirl.create(:quiz)
        Quiz.last.finish_incomplete
      end
    end
    roster = FactoryGirl.create(:roster)
    roster.lessons << Lesson.all[0..4]
    total_avg_score = user.completed_quizzes.map {|quiz| quiz.score}.sum / user.completed_quizzes.size
    
    expect(user.roster_avg_score(roster)).to eq(0.6) #3 Passing Tests Across 5 Lessons
    expect(total_avg_score).to eq(0.3)  
  end
  
  it 'should calculate average score as 0 across on quiz attempts for the lessons on a given roster if there are no quiz attempts' do
    user = FactoryGirl.create(:user)
    roster = FactoryGirl.create(:roster)
    
    expect(user.roster_avg_score(roster)).to eq(0) #3 Passing Tests Across 5 Lessons
  end
  
  it 'should calculate total video views on a specific lesson'
  
  it 'should calculate total video views on all lessons associated with a given roster'
  
  it 'should update user belts based on completed lessons'

end
