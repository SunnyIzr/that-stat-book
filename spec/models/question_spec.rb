require 'spec_helper'

describe Question do
  it {should have_many (:choices)}
  it {should belong_to (:lesson)}
  it {should validate_presence_of (:question)}
  it {should validate_presence_of (:lesson_id)}

  it 'should return a random question for a specified lesson' do
    100.times do
      lesson = FactoryGirl.create(:lesson)
      5.times { lesson.questions << FactoryGirl.create(:question,:lesson_id => lesson.id)}
    end
    lesson = Lesson.all.sample
    expect(Question.random(lesson.id).class).to eq(Question)
    expect(Question.random(lesson.id).lesson).to eq(lesson)

  end
end
