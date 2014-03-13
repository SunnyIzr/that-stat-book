# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson do
    title {'Test Lesson'}
    level {1}
  end
end
