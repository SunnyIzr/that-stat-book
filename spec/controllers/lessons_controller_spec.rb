require 'spec_helper'

describe LessonsController do
  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:user, admin: true)}
  
  describe 'GET #show' do
    context 'user is admin' do
      it 'should populate all active questions for a specific lesson'
      it 'should render :show view for a specific lesson on html request'
      it 'should render lesson object as json object on json request'
    end
    context 'user is student' do
      it 'should render text indicating that this is a restricted area'
    end
  end
  
  describe 'GET #index' do
    context 'user is admin' do
      it 'should populate all lessons sorted by level'
      it 'should render :index view'
    end
    context 'user is student' do
      it 'should render text indicating that this is a restricted area'
    end
  end
  
  describe 'PUT #update' do
    context 'user is admin' do
      it "should update a specified lessons level's level"
      it 'should render lesson object as json'
    end
  end
  
  describe 'DELETE #destroy' do
    context 'user is admin' do
      it 'should destroy specified lesson'
      it 'should fill level gap in all lessons'
      it 'should redirect to lessons#index'
    end
  end
  
  describe 'GET #new' do
    context 'user is admin' do
      it 'should render :new view'
    end
  end
  
  describe 'POST #create' do
    context 'user is admin' do
      it 'create a new lesson with specified params'
      it 'should assign max belt level to new lesson'
      it 'should redirect to lesson#show'
    end
  end
  
  describe 'GET #rearrange' do
    it 'should render :rearrange view'
  end
  
  describe 'POST #sort' do
    it 'should set new levels for all lessons given new levels'
  end

end
