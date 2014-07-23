require 'spec_helper'

describe ChoicesController do
  let(:student) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:user, admin: true)}
  let(:professor) {FactoryGirl.create(:professor)}  

  describe 'get #show' do
    context 'user is admin' do
      it 'renders a specified choice as json object upon json request' do
        sign_in(admin)
        choice = FactoryGirl.create(:choice)
        
        get :show, {id: choice.id, format: :json}
        
        expect(response.body).to eq(choice.to_json)
      end
    end
  end
  
  describe 'patch #update' do
    it 'updates a choice with specified attributes' do
      sign_in(admin)
      choice = FactoryGirl.create(:choice)
      
      patch :update, {id: choice.id, choice: {choice: 'a brand new choice!'}, format: :json}
      
      expect(Choice.last.choice).to eq('a brand new choice!')
    end
    it 'renders updated choice as json object upon json request' do
      sign_in(admin)
      choice = FactoryGirl.create(:choice)
      
      patch :update, {id: choice.id, choice: {choice: 'a brand new choice!'}, format: :json}
      
      expect(response.body).to eq(Choice.last.to_json)
    end
  end
end
