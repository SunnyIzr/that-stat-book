# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :professor do
    email {'prof@prof.com'}
    password {'prof-password'}
  end
end
