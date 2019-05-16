FactoryBot.define do
  factory :post do
    title     { Faker::Nation.nationality }
    content   { Faker::Nation.capital_city }
    user_id   { Faker::Number.within(1..10) }
  end
end
