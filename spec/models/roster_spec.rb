require 'spec_helper'

describe Roster do
  let(:total_questions) {ENV['QUIZ_QUESTIONS'].to_i}
  
  it {should belong_to (:professor)}
  it {should have_and_belong_to_many (:users)}
  it {should have_and_belong_to_many (:lessons)}
  
  it 'should generate all quiz attempts for all associated users on all associated lessons' do
    10.times { |i| FactoryGirl.create(:user, email: "#{i}@gmail.com")}
    roster = FactoryGirl.create(:roster)
    roster.users = User.all[0..3]
    
    7.times do |i|
      FactoryGirl.create(:lesson)
      (total_questions*3).times do 
        FactoryGirl.create(:question)
        FactoryGirl.create(:choice, question_id: Question.last.id)
      end
      User.all.each do |user|
        3.times do
          FactoryGirl.create(:quiz, user_id: user.id)
          Quiz.last.finish_incomplete
        end
      end
    end
    
    roster.lessons = Lesson.all[0..4]
    
    expect(roster.quiz_attempts.size).to eq(60) #4 Users * 5 Lessons * 3 Attempts    
  end
  
  it 'should calculate average score across all quiz attempts on all associated users on all associated lessons' do
    10.times { |i| FactoryGirl.create(:user, email: "#{i}@gmail.com")}
    roster = FactoryGirl.create(:roster)
    roster.users = User.all[0..3]
    
    3.times do |i| #Generating first 3 lessons
      FactoryGirl.create(:lesson)
      (total_questions*3).times do 
        FactoryGirl.create(:question)
        FactoryGirl.create(:choice, question_id: Question.last.id, is_correct: true)
      end
      User.all.each do |user|
        3.times do #Generating 3 passing 100% quizes for each user on each lesson
          FactoryGirl.create(:quiz, user_id: user.id)
          total_questions.times do |i|
            questions = Question.where(lesson_id: Lesson.last.id)
            FactoryGirl.create(:answer_submission, quiz_id: Quiz.last.id, choice_id: questions[i].choices.first.id)
          end
        end
      end
    end
    
    
    5.times do |i| #Generating next 5 lessons
      FactoryGirl.create(:lesson)
      (total_questions*3).times do 
        FactoryGirl.create(:question)
        FactoryGirl.create(:choice, question_id: Question.last.id)
      end
      User.all.each do |user|
        3.times do #Generating 3 failing quizes for each user on eaach leasson
          FactoryGirl.create(:quiz, user_id: user.id)
          Quiz.last.finish_incomplete
        end
      end
    end
    
    roster.lessons = Lesson.all[0..4]
    10.times {Quiz.first.destroy}
    expect(roster.avg_score).to eq(0.52) #(4 Users * 3 Passings Lessons * 3 Quizes) - 3 Passing Quizzes / 4 Users * 5 Lessons * 3 Quizzes
  end
  
  it 'should calculate total video views on all associated lessons across all associated users'
end
