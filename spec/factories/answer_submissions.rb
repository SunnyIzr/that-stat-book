# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer_submission do
    choice {FactoryGirl.create(:choice)}
    quiz {FactoryGirl.create(:quiz)}
  end
end
