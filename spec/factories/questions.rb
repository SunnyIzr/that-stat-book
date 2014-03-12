# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    question {'This is a test question'}
    lesson {FactoryGirl.create(:lesson)}
  end
end
