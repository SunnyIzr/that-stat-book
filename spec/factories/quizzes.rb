# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quiz do
    lesson {Lesson.last.nil? ? FactoryGirl.create(:lesson) : Lesson.last}
    user { User.last.nil? ? FactoryGirl.create(:user) : User.last}
  end
end
