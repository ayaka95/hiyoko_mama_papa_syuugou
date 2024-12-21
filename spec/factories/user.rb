FactoryBot.define do
  factory :user do
    name { Faker::Name }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number:6) }
    updated_at { DateTime.now }
    created_at { DateTime.now }
  end
end