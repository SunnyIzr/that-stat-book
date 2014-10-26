require 'spec_helper'

describe ClassRequest do
  it {should belong_to (:user)}
  it {should belong_to (:roster)}
  it {should have_one (:professor)}
  it {should validate_presence_of (:user)}
  it {should validate_presence_of (:roster)}
  
  it 'should validate that the user it belongs to MUST be a student' do
    prof = FactoryGirl.create(:professor)
    student = FactoryGirl.create(:user)
    roster = FactoryGirl.create(:roster)
    class_request = ClassRequest.new(user_id: prof.id, roster_id: roster.id)
    expect(class_request.valid?).to eq(false)
  end
  it 'should validate that the a request for a specifc user/roster does not already exist' do
    prof = FactoryGirl.create(:professor)
    student = FactoryGirl.create(:user)
    roster = FactoryGirl.create(:roster)
    class_request1 = ClassRequest.create(user_id: student.id, roster_id: roster.id)
    class_request2 = ClassRequest.new(user_id: student.id, roster_id: roster.id)
    expect(class_request2.valid?).to eq(false)
  end
  it 'should accept a student' do
    roster = FactoryGirl.create(:roster)
    student = FactoryGirl.create(:user)
    class_request = ClassRequest.create(user_id: student.id, roster_id: roster.id)
    class_request.accept!
    
    expect(roster.users).to match_array([student])
  end
end
