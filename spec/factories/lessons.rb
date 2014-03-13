# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson do
    title {'Test Lesson'}
    level {Lesson.last.nil? ? 1 : Lesson.last.level + 1}
  end
end
