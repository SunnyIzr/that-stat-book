require 'spec_helper'

describe RostersController do
  let(:student) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:user, admin: true)}
  let(:professor) {FactoryGirl.create(:professor)}
  
  describe 'GET #index' do
    context 'user is professor' do
      it 'should render :index_professor template' do
        sign_in(professor)
        get :index
        expect(response).to render_template(:index_professor)
      end
    end
    context 'user is student' do
      it 'should render :index_student template' do
        sign_in(student)
        get :index
        expect(response).to render_template(:index_student)
      end
    end
  end
  
  describe 'GET #show' do
    context 'user is professor' do
      it 'should render :show_professor template' do
        sign_in(professor)
        FactoryGirl.create(:roster)
        get :show, {id: Roster.last.id.to_s}
        expect(response).to render_template(:show_professor)
      end
    end
    context 'user is student' do
      it 'should render :show_student template' do
        sign_in(student)
        FactoryGirl.create(:roster)
        get :show, {id: Roster.last.id.to_s}
        expect(response).to render_template(:show_student)
      end
    end
  end
  
  describe 'GET #new' do
    context 'user is professor' do
      it 'should render :new template' do
        sign_in(professor)
        get :new
        expect(response).to render_template(:new)
      end
    end
  end
  
  describe 'POST #create' do
    context 'user is professor' do
      it 'should create a new roster with specified params' do
        sign_in(professor)
        10.times { |i| FactoryGirl.create(:user, email: "#{i}@gmail.com")}
        student_ids = User.where(type: nil).map{|student| student.id.to_s}[0..4]
        
        post :create, {roster: {title: 'my brand new roster!',user_ids: student_ids}}
        
        expect(Roster.last.title).to eq('my brand new roster!')
        expect(Roster.last.professor).to eq(Professor.last)
        expect(Roster.last.users).should match_array(User.all[1..5])
      end
      it 'should redirect to roster#show' do
        sign_in(professor)
        post :create, {roster: {title: 'my brand new roster!'}}
        
        expect(response).to redirect_to(Roster.last)
      end
    end
  end
  
  describe 'PATCH #update' do
    context 'user is professor' do
      it 'should update existing roster with new attribtues' do
        sign_in(professor)
        10.times { |i| FactoryGirl.create(:user, email: "#{i}@gmail.com")}
        10.times {FactoryGirl.create(:lesson)}
        roster = FactoryGirl.create(:roster,title:'old title')
        roster.users << User.all[1..5]
        roster.lessons << Lesson.all[0..4]
        roster.save
        
        new_student_ids = User.all[6..10].map{|student| student.id.to_s}
        new_lesson_ids = Lesson.all[5..9].map{|lesson| lesson.id.to_s}
        
        patch :update, {id: roster.id.to_s, roster: {title: 'new title', user_ids: new_student_ids, lesson_ids: new_lesson_ids}, format: :json}
        
        expect(Roster.last.title).to eq('new title')
        expect(Roster.last.users).should match_array(User.all[6..10])
        expect(Roster.last.lessons).should match_array(Lesson.all[5..9])
        
      end
    end  
  end
  
  
  
  
end