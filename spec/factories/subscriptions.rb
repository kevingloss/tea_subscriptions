FactoryBot.define do
  factory :subscription do
    customer
    status { Faker::Number.within(range: 0..1) }
    frequency { Faker::Number.within(range: 0..2) }
  end
end