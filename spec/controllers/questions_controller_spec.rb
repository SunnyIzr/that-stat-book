require 'spec_helper'

describe QuestionsController do
  
  describe 'GET #show' do
    context 'user is admin' do
      it 'should render :show_admin view for a specific question on html request'
      it 'should render specific question as json object on json request'
    end
    context 'user is student' do
    end
  end
  
  describe 'GET #show_random_question' do
  end
  
  describe 'GET #new' do
  end
  
  describe 'POST #create' do
  end
  
  describe 'DELETE #destroy' do
  end
  
  describe 'PATCH #update' do
  end
  
  describe 'GET #delete_image' do
  end
  
end
