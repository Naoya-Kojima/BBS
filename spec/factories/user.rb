FactoryBot.define do
  factory :user do
    name                  { Faker::Name.name }
    email                 { Faker::Internet.email }
    password              { 'password1234' }
    password_confirmation { 'password1234' }
    salt                  { 'asdasdastr4325234324sdfds' }
    sex                   { 0 }
  end
end
