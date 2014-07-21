require 'spec_helper'

describe UsersController do
  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:user, admin: true)}
  let(:professor) {FactoryGirl.create(:professor)}
  
  describe 'GET #dashboard' do
    context 'user is admin' do
      it 'should redirect to lessons index' do
        sign_in(admin)
        get :dashboard
        expect(response).to redirect_to(:lessons)
      end
    end
    context 'user is student' do
      it 'should render the :user_dashboard view' do
        sign_in(user)
        get :dashboard
        expect(response).to render_template(:user_dashboard)
      end
    end
    context 'user is professor' do
      it 'should redirect to roster#index' do
        sign_in(professor)
        get :dashboard
        expect(response).to redirect_to(:rosters)
      end
    end
  end
  
  describe 'GET #summary' do
    context 'user is student' do
      it 'should render user summary' do
        sign_in(user)
        get :summary
        expect(response).to render_template(:summary)
      end
    end
  end
  
  describe 'GET #index' do
    context 'user is admin' do
      it 'should populate a list of all users' do
        sign_in(admin)
        10.times { |i| FactoryGirl.create(:user, email: "#{i.to_s}@gmail.com")}
        get :index
        assigns(:users).should eq(User.all)
      end
      it 'should render users index view' do
        sign_in(admin)
        get :index
        expect(response).to render_template(:index)
      end
    end
  end
  
  describe 'GET #show' do
    context 'user is admin' do
      it 'should return specified user' do
        5.times { |i| FactoryGirl.create(:user, email: "#{i.to_s}@gmail.com")}
        sign_in(admin)
        get :show, {id: User.first.id.to_s}
        assigns(:user).should eq(User.first)
      end
      it 'should render the :show view' do
        5.times { |i| FactoryGirl.create(:user, email: "#{i.to_s}@gmail.com")}
        sign_in(admin)
        get :show, {id: User.first.id.to_s}
        expect(response).to render_template(:show)
      end
    end
  end

end
