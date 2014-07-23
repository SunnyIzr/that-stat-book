require 'spec_helper'

describe QuizzesController do
  let(:student) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:user, admin: true)}
  let(:professor) {FactoryGirl.create(:professor)}
  let(:total_questions) {ENV['QUIZ_QUESTIONS'].to_i}

  describe 'POST #create' do
    context 'user is taking a quiz via the belt route' do
      context 'there are no outstanding quizzes in the belt route that map to this lesson' do
        it 'should create a new quiz that matches off with lesson, and user attributes' do
          sign_in(student)
          lesson = FactoryGirl.create(:lesson)

          post :create, {lesson_id: lesson.id}
          
          expect(Quiz.last.lesson).to eq(Lesson.last)
          expect(Quiz.last.user).to eq(student)
          expect(Quiz.last.belt?).to eq(true)
        end
      end
      context 'there is an outstanding quiz in the belt route that maps to this lesson' do
        it 'should resume the last incomplete quiz that corresponds to the lesson' do
          sign_in(student)
          lesson = FactoryGirl.create(:lesson)
          quiz = FactoryGirl.create(:quiz)
  
          post :create, {lesson_id: lesson.id}
    
          expect(Quiz.all.size).to eq(1)
        end
      end
    end
    context 'user is taking a quiz via a specific roster router' do
      context 'there are no outstanding quizzes in that specific roster route that maps to the given lesson' do
        it 'should create a new quiz that matches off with lesson, roster id and user attributes' do
          sign_in(student)
          lesson = FactoryGirl.create(:lesson)
          roster = FactoryGirl.create(:roster)
          roster.lessons << lesson
          
          post :create, {lesson_id: lesson.id, roster_id: roster.id}
          
          expect(Quiz.last.lesson).to eq(Lesson.last)
          expect(Quiz.last.user).to eq(student)
          expect(Quiz.last.roster?).to eq(true)
        end
      end
      context 'there is an outstanding quiz in this specific roster route that maps to this lesson' do
        it 'should resume the last incomplete quiz that corresponds to the lesson' do
          sign_in(student)
          lesson = FactoryGirl.create(:lesson)
          roster = FactoryGirl.create(:roster)
          roster.lessons << lesson
          quiz = FactoryGirl.create(:quiz, roster_id: roster.id)
  
          post :create, {lesson_id: lesson.id, roster_id: roster.id}
    
          expect(Quiz.all.size).to eq(1)
        end
      end
    end
    it 'should redirect to random_question route' do
      sign_in(student)
      lesson = FactoryGirl.create(:lesson)

      post :create, {lesson_id: lesson.id}
      
      expect(response).to redirect_to(random_question_path(quiz_id: Quiz.last.id))
    end
    
  end
  
  describe 'GET #show' do
    context 'quiz is complete' do
      it 'should render :show view' do
        sign_in(student)
        quiz = FactoryGirl.create(:quiz)
        total_questions.times do
          FactoryGirl.create(:question)
          FactoryGirl.create(:choice)
          FactoryGirl.create(:answer_submission, choice_id: Choice.last.id, quiz_id: quiz.id)
        end
        
        get :show, {id: quiz.id}
        
        expect(response).to render_template(:show)
      end
    end
    context 'quiz is incomplete' do
      it 'should render :incomplete view' do
        sign_in(student)
        quiz = FactoryGirl.create(:quiz)
        
        get :show, {id: quiz.id}
        
        expect(response).to render_template(:incomplete)
      end
    end
  end
  
  describe 'post #countdown' do
    it 'should count down remaining time on quiz by 1 second' do
      sign_in(student)
      quiz = FactoryGirl.create(:quiz)
      
      post :countdown, {quiz_id: quiz.id}
      
      expect(Quiz.last.time).to eq(1799)
    end
    it 'should render new remaining time as text after countdown' do
      sign_in(student)
      quiz = FactoryGirl.create(:quiz)
      
      post :countdown, {quiz_id: quiz.id}
      
      expect(response.body).to eq('29:59')
    end
  end
  
  describe 'get #incomplete' do
    it 'should take an incomplete quiz and make complete with wrong answers for scoring purpoes' do
      sign_in(student)
      quiz = FactoryGirl.create(:quiz)
      total_questions.times do
        FactoryGirl.create(:question)
        FactoryGirl.create(:choice, question_id: Question.last.id)
      end
      
      get :incomplete, {quiz_id: quiz.id}
      
      expect(Quiz.last.complete?).to eq(true)
    end
    it 'should redirect to quiz#show page' do
      sign_in(student)
      quiz = FactoryGirl.create(:quiz)
      total_questions.times do
        FactoryGirl.create(:question)
        FactoryGirl.create(:choice, question_id: Question.last.id)
      end
    
      get :incomplete, {quiz_id: quiz.id}
      
      expect(response).to redirect_to(quiz)
    end
  end
  
  describe 'get #certificate' do
    context 'user has passed the quiz' do
      it 'should render :certificate template' do
        sign_in(student)
        quiz = FactoryGirl.create(:quiz)
        total_questions.times do
          FactoryGirl.create(:question)
          FactoryGirl.create(:choice, is_correct: true)
          FactoryGirl.create(:answer_submission, choice_id: Choice.last.id, quiz_id: quiz.id)
        end
        
        get :certificate, {quiz_id: quiz.id}
        
        expect(response).to render_template(:certificate)
      end
    end
    context 'user has failed the quiz' do
      it 'should render fail text' do
        sign_in(student)
        quiz = FactoryGirl.create(:quiz)
        total_questions.times do
          FactoryGirl.create(:question)
          FactoryGirl.create(:choice)
          FactoryGirl.create(:answer_submission, choice_id: Choice.last.id, quiz_id: quiz.id)
        end
        
        get :certificate, {quiz_id: quiz.id}
        
        expect(response.body).to eq('This Quiz is a Fail.')
      end
    end
  end
end
