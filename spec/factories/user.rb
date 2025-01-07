FactoryBot.define do
  factory :user do
    sequence(:name) { |n| 'user_#{n}' }
    sequence(:email) { |n| 'user_#{n}@example.com' }
    introduction { Faker::Lorem.characters(number: 100) }
    password { 'password' }
    password_confirmation { 'password' }
    updated_at { DateTime.now }
    created_at { DateTime.now }
  end
end