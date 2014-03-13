# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    question {'This is a test question'}
    lesson {Lesson.last.nil? ? FactoryGirl.create(:lesson) : Lesson.last}
  end
end
