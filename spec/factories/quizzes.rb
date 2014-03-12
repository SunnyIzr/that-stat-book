# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quiz do
    lesson {FactoryGirl.create(:lesson)}
    user {FactoryGirl.create(:user)}
  end
end
