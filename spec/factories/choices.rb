# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :choice do
    choice {'This is a test choice'}
    question {FactoryGirl.create(:question)}
  end
end
