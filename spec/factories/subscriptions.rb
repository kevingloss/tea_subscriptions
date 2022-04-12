FactoryBot.define do
  factory :subscription do
    customer
    price { Faker::Number.number(digits: 5) }
    status { Faker::Number.within(range: 0..2) }
    frequency { Faker::Number.within(range: 0..2) }
  end
end