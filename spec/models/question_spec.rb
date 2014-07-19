require 'spec_helper'

describe Question do
  it {should have_many (:choices)}
  it {should belong_to (:lesson)}
  it {should validate_presence_of (:question)}
  it {should validate_presence_of (:lesson_id)}

  it 'should return the answer' do
    question = FactoryGirl.create(:question)
    3.times { FactoryGirl.create(:choice, question_id: question.id) }
    answer = FactoryGirl.create(:choice, question_id: question.id, is_correct: true)

    expect(question.answer).to eq(answer)
  end
  
  it 'should return a hash containing all amazon s3 credentials; this is used for attaching optional image file for a given quesiton' do
    question = FactoryGirl.create(:question)
    expect(question.s3_credentials).to eq({:bucket => ENV['BUCKET'], :access_key_id => ENV['ACCESS_KEY_ID'], :secret_access_key => ENV['SECRET_ACCESS_KEY']})
  end
end
