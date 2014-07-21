# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :roster do
    title {'Test Roster'}
    professor { Professor.last.nil? ? FactoryGirl.create(:professor) : Professor.last}
  end
end
