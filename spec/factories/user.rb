FactoryBot.define do
  factory :user do
    name                  { Faker::Name.name }
    email                 { Faker::Internet.safe_email }
    password              { 'password1234' }
    password_confirmation { 'password1234' }
    sex                   { Faker::Number.within(0..1) }
  end
end
