FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.first_name }
    password { 'password123' }
    password_confirmation { 'password123' }
    surname { Faker::Name.last_name}
    gender { Faker::Gender.binary_type}
    category { ["Beginner", "C", "С+", "B", "A"].sample }
    rating { Faker::Number.between(from: 0, to: 1000)}
    position { Faker::Number.between(from: 1, to: 100)}
    date_of_birth { Faker::Date.birthday(min_age: 15, max_age: 65) }
  end
end