require 'spec_helper'

describe AnswerSubmissionsController do
  let(:student) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:user, admin: true)}
  let(:professor) {FactoryGirl.create(:professor)}  
  let(:total_questions) {ENV['QUIZ_QUESTIONS'].to_i}
  
  describe 'post #create' do
    it 'should save down a new answer submission' do
      sign_in(student)
      quiz = FactoryGirl.create(:quiz)
      total_questions.times do
        FactoryGirl.create(:question)
        FactoryGirl.create(:choice)
      end
      
      post :create, {quiz_id: quiz.id, choice_id: Choice.last.id}
      
      expect(AnswerSubmission.last.quiz).to eq(quiz)
      expect(AnswerSubmission.last.choice).to eq(Choice.last)
    end
    
    context 'quiz is still incomplete after answer submission' do
      it 'should redirect to random_question path' do
        sign_in(student)
        quiz = FactoryGirl.create(:quiz)
        total_questions.times do
          FactoryGirl.create(:question)
          FactoryGirl.create(:choice)
        end
        
        post :create, {quiz_id: quiz.id, choice_id: Choice.last.id}
        
        expect(response).to redirect_to(random_question_path(quiz_id: quiz.id))
      end
    end
    context 'quiz has been completed after answer submission' do
      it 'should redirect to Quiz#show path' do
        sign_in(student)
        quiz = FactoryGirl.create(:quiz)
        total_questions.times do |i|
          FactoryGirl.create(:question)
          FactoryGirl.create(:choice)
          FactoryGirl.create(:answer_submission, quiz_id: quiz.id, choice_id: Choice.last.id) unless i == (total_questions - 1)
        end
        
        post :create, {quiz_id: quiz.id, choice_id: Choice.last.id}
        
        expect(response).to redirect_to(quiz_path(quiz))
      end
    end
  end

end
