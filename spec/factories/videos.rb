# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    lesson {Lesson.last.nil? ? FactoryGirl.create(:lesson) : Lesson.last}
  end
end
