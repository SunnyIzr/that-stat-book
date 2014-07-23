# Read about factories at https://github.com/thoughtbot/factory_girl
belts = %w[yellow orange green blue purple red brown black]

FactoryGirl.define do
  factory :belt do
    belt {belts[Belt.all.size]}
  end
end
