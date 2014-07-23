require 'spec_helper'

describe QuestionsController do
  let(:student) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:user, admin: true)}
  let(:professor) {FactoryGirl.create(:professor)}  

  describe 'GET #show' do
    context 'user is admin/professor' do
      it 'should render :show_admin view for a specific question on html request' do
        sign_in(admin)
        question = FactoryGirl.create(:question)
        
        get :show, {id: question.id}
        
        expect(response).to render_template(:show_admin)
        
      end
      it 'should render specific question as json object on json request' do
        sign_in(professor)
        question = FactoryGirl.create(:question)
        
        get :show, {id: question.id, format: :json}
        
        expect(response.body).to eq(question.to_json)
      end
    end
    context 'user is student' do
      it 'should render :show view for a specific question' do
        sign_in(student)
        question = FactoryGirl.create(:question)
        quiz = FactoryGirl.create(:quiz)
        
        get :show, {id: question.id, quiz_id: quiz.id}
        
        expect(response).to render_template(:show)
      end
    end
  end
  
  describe 'GET #show_random_question' do
    it 'should redirect to question#show for a random question' do
      sign_in(student)
      question = FactoryGirl.create(:question)
      quiz = FactoryGirl.create(:quiz)
      
      get :show_random_question, {quiz_id: quiz.id}
      
      expect(response).to redirect_to(question_path(id:question.id, quiz_id:quiz.id))
    end
  end
  
  describe 'GET #new' do
    context 'user is admin' do
      it 'should create a question with 4 choices' do
        sign_in(admin)
        lesson = FactoryGirl.create(:lesson)
        
        get :new, {lesson_id: lesson.id}
        
        expect(assigns(:question).class).to eq(Question)
        expect(assigns(:question).lesson).to eq(lesson)
        expect(assigns(:question).choices.size).to eq(4)
      end
      it 'should render :new view' do
        sign_in(admin)
        lesson = FactoryGirl.create(:lesson)
        
        get :new, {lesson_id: lesson.id}
        
        expect(response).to render_template(:new)
      end
    end
  end
  
  describe 'POST #create' do
    context 'user is admin' do
      it 'should create a new question with specified params' do
        sign_in(admin)
        lesson = FactoryGirl.create(:lesson)
        
        post :create, {lesson_id: lesson.id, question: {question: 'What is the meaning of life?', lesson_id: lesson.id, choices_attributes:{'0' => {choice: 'Choice A'},'1' => {choice: 'Choice B'},'2' => {choice: 'Choice C'},'3' => {choice: 'Choice D'} } } }
        
        expect(Question.last.question).to eq('What is the meaning of life?')
        expect(Question.last.lesson).to eq(lesson)
        expect(Question.last.choices[0].choice).to eq('Choice A')
        expect(Question.last.choices[1].choice).to eq('Choice B')
        expect(Question.last.choices[2].choice).to eq('Choice C')
        expect(Question.last.choices[3].choice).to eq('Choice D')
      end
    
      it 'should mark the first choice as correct' do
        sign_in(admin)
        lesson = FactoryGirl.create(:lesson)
        
        post :create, {lesson_id: lesson.id, question: {question: 'What is the meaning of life?', lesson_id: lesson.id, choices_attributes:{'0' => {choice: 'Choice A'},'1' => {choice: 'Choice B'},'2' => {choice: 'Choice C'},'3' => {choice: 'Choice D'} } } }
      
        expect(Question.last.choices[0].choice).to eq('Choice A')
        expect(Question.last.choices[0].is_correct).to eq(true)
      end
      
      it 'should redirect to question#show' do
        sign_in(admin)
        lesson = FactoryGirl.create(:lesson)
        
        post :create, {lesson_id: lesson.id, question: {question: 'What is the meaning of life?', lesson_id: lesson.id, choices_attributes:{'0' => {choice: 'Choice A'},'1' => {choice: 'Choice B'},'2' => {choice: 'Choice C'},'3' => {choice: 'Choice D'} } } }
        
        expect(response).to redirect_to(Question.last)
      end
      
      it 'should indicate error if invalid attributes were received' do
        sign_in(admin)
        lesson = FactoryGirl.create(:lesson)
        
        post :create, {lesson_id: lesson.id, question: {question: nil, lesson_id: lesson.id, choices_attributes:{'0' => {choice: 'Choice A'},'1' => {choice: 'Choice B'},'2' => {choice: 'Choice C'},'3' => {choice: 'Choice D'} } } }
        
        expect(response.body).to eq('ERROR')
      end
    end
  end
  
  describe 'DELETE #destroy' do
    context 'user is admin' do
      it 'should inactivate a specified question' do
        sign_in(admin)
        question = FactoryGirl.create(:question)
        
        delete :destroy, {id: question.id}
        
        expect(Question.last.active).to eq(false)
      end
      it 'should redirect to lessons#show page' do
        sign_in(admin)
        question = FactoryGirl.create(:question)
        
        delete :destroy, {id: question.id}
        
        expect(response).to redirect_to(Lesson.last)
      end
    end
  end
  
  describe 'PATCH #update' do
    context 'user is admin' do
      it "should update a question's attributes" do
        sign_in(admin)
        lesson = FactoryGirl.create(:lesson)
        question = FactoryGirl.create(:question)
        
        patch :update, {id: question.id, question: {question: 'What is the meaning of life?'} }
        
        expect(Question.last.question).to eq('What is the meaning of life?')
      end
      
      it 'should redirect to question#show page upon html request' do
        sign_in(admin)
        lesson = FactoryGirl.create(:lesson)
        question = FactoryGirl.create(:question)
        
        patch :update, {id: question.id, question: {question: 'What is the meaning of life?'},}
        
        expect(response).to redirect_to(Question.last)
      end
      
      it 'should render the question as a json object upon json request' do
        sign_in(admin)
        lesson = FactoryGirl.create(:lesson)
        question = FactoryGirl.create(:question)
        
        patch :update, {id: question.id, question: {question: 'What is the meaning of life?'}, format: :json}
        
        expect(response.body).to eq(Question.last.to_json)
      end
      
      it 'should return a 200 error if the new data does not persist' do
        sign_in(admin)
        
      end
    end
  end
  
end
