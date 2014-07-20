require 'spec_helper'

describe Roster do
  it {should belong_to (:professor)}
  it {should have_and_belong_to_many (:users)}
  it {should have_and_belong_to_many (:lessons)}
  
  # it 'should generate all quiz attempts for all associated users on all associated lessons' do
  #   10.times {FactoryGirl.create(:user)}
  #   roster = FactoryGirl.create(:roster)
    
  # end
  
  # it 'should calculate average score across all quiz attempts on all associated users on all associated lessons' do
  # end
  
  # it 'should calculate total video views on all associated lessons across all associated users' do
  # end
end
