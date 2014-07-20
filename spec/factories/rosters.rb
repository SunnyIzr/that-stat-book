# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :professor do
    title {'Test Roster'}
    roster { Professor.last.nil? ? FactoryGirl.create(:professor) : Professor.last}
  end
end