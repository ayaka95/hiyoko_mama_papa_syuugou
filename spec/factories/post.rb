FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 50) }
    user_id { Faker::Number.non_zero_digit }
    updated_at { DateTime.now }
    created_at { DateTime.now }
    association :user
  end
end
