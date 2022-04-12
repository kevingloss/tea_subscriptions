FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    price { Faker::Number.number(digits: 4) }
    description { Faker::Tea.type }
    temperature { Faker::Number.within(range: 212.0..300.0).round(2) }
    brew_time { Faker::Number.within(range: 180..600) }
  end
end