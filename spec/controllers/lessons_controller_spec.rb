require 'spec_helper'

describe LessonsController do
  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:user, admin: true)}
  
  describe 'GET #show' do
    context 'user is admin' do
      it 'should populate all active questions for a specific lesson' do
        sign_in(admin)
        4.times {FactoryGirl.create(:question)}
        1.times {FactoryGirl.create(:question, active: false)}
        get :show, {id: Lesson.first.id.to_s}
        assigns(:questions).should eq(Question.all[0..3].reverse)
      end
      it 'should render :show view for a specific lesson on html request' do
        sign_in(admin)
        4.times {FactoryGirl.create(:question)}
        get :show, {id: Lesson.first.id.to_s}
        expect(response).to render_template(:show)
      end
      it 'should render lesson object as json object on json request' do
        sign_in(admin)
        4.times {FactoryGirl.create(:question)}
        get :show, {id: Lesson.first.id.to_s, format: :json}
        expect(response.body).to eq(Lesson.first.to_json)
      end
      
    end
    context 'user is student' do
      it 'should render text indicating that this is a restricted area' do
        sign_in(user)
        4.times {FactoryGirl.create(:question)}
        get :show, {id: Lesson.first.id.to_s}
        expect(response.body).to eq('Restricted')
      end
    end
  end
  
  describe 'GET #index' do
    context 'user is admin' do
      it 'should render :index view' do
        sign_in(admin)
        get :index
        expect(response).to render_template(:index)
      end
    end
    context 'user is student' do
      it 'should render text indicating that this is a restricted area' do
        sign_in(user)
        get :index
        expect(response.body).to eq('Restricted')
      end
    end
  end
  
  describe 'PUT #update' do
    context 'user is admin' do
      it "should update a lesson's attributes" do
        sign_in(admin)
        FactoryGirl.create(:lesson)
        patch :update, {id: Lesson.first.id.to_s,lesson:{title: 'new title'},format: :json}
        expect(Lesson.first.title).to eq('new title')
      end
      it 'should render lesson object as json' do
        sign_in(admin)
        FactoryGirl.create(:lesson)
        patch :update, {id: Lesson.first.id.to_s,lesson:{title: 'new title'},format: :json}
        expect(response.body).to eq(Lesson.first.to_json)
      end
    end
  end
  
  describe 'DELETE #destroy' do
    context 'user is admin' do
      it 'should destroy specified lesson' do
        sign_in(admin)
        10.times{ |i| FactoryGirl.create(:lesson, level: (i+1)) }
        delete :destroy, {id: Lesson.first.id.to_s}
        expect(Lesson.all.size).to eq(9)
      end
      it 'should fill level gap in all lessons' do
        sign_in(admin)
        10.times{ |i| FactoryGirl.create(:lesson, level: (i+1)) }
        delete :destroy, {id: Lesson.first.id.to_s}
        expect(Lesson.levels).to eq([1,2,3,4,5,6,7,8,9])
      end
      it 'should redirect to lessons#index' do
        sign_in(admin)
        10.times{ |i| FactoryGirl.create(:lesson, level: (i+1)) }
        delete :destroy, {id: Lesson.first.id.to_s}
        expect(response).to redirect_to(:lessons)
      end
    end
  end
  
  describe 'GET #new' do
    context 'user is admin' do
      it 'should render :new view' do
        sign_in(admin)
        get :new
        expect(response).to render_template(:new)
      end
    end
  end
  
  describe 'POST #create' do
    context 'user is admin' do
      it 'create a new lesson with specified params' do
        sign_in(admin)
        Belt.create(belt: 'white')
        FactoryGirl.create(:lesson, belt_id: Belt.first.id)
        post :create, {lesson: {title: 'brand new lesson', belt_id: Belt.first.id.to_s}, format: :json}
        expect(Lesson.last.title).to eq('brand new lesson')
      end
      it 'should redirect to lesson#show' do
        sign_in(admin)
        Belt.create(belt: 'white')
        FactoryGirl.create(:lesson, belt_id: Belt.first.id)
        post :create, {lesson: {title: 'brand new lesson', belt_id: Belt.first.id.to_s}, format: :json}
        expect(response).to redirect_to(Lesson.last)
      end
    end
  end
  
  # describe 'GET #rearrange' do
  #   it 'should render :rearrange view'
  # end
  
  # describe 'POST #sort' do
  #   it 'should set new levels for all lessons given new levels'
  # end

end
