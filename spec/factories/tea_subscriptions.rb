FactoryBot.define do
  factory :tea_subscription do
    tea
    subscription
    tea_qty { Faker::Number.within(range: 8..100) }
    tea_price { Faker::Number.number(digits: 4) }
  end
end