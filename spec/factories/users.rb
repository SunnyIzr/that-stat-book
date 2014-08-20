# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name {'John'}
    last_name {'Doe'}
    email {'test@test.com'}
    password {'test-password'}
  end
end
