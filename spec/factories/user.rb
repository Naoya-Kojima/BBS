FactoryBot.define do
  factory :user do
    name                  { Faker::Name.name }
    email                 { Faker::Internet.safe_email }
    password              { 'password1234' }
    password_confirmation { 'password1234' }
    sex                   { 0 }
  end
end
