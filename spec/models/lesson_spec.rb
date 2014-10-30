require 'spec_helper'

describe Lesson do
  it {should have_many (:questions)}
  it {should have_many (:quizzes)}
  it {should have_many (:videos)}
  it {should have_many (:learning_modules)}
  it {should have_and_belong_to_many (:rosters)}
  it {should validate_presence_of (:title)}
  it {should validate_presence_of (:level)}
  it {should validate_uniqueness_of (:level)}
  
  it 'should return a sequential list of all levels' do
    5.times {FactoryGirl.create(:lesson)}
    expect(Lesson.levels).to eq([1,2,3,4,5])
  end
  
  it 'should all subsequent lessons up one levels given a specific starting point; this is used for when admin would like to remap levels' do
    5.times {FactoryGirl.create(:lesson)}
    Lesson.create_empty(3)
    expect(Lesson.levels).to eq([1,2,4,5,6])
  end
  
  it 'should move all subsequent lessons down one level given a specific level that is currently empty; this is used for when admin would like to remap levels' do
    5.times {FactoryGirl.create(:lesson)}
    Lesson.create_empty(3)
    Lesson.fill_empty(3)
    expect(Lesson.levels).to eq([1,2,3,4,5])
  end
  
end
