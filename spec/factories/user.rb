FactoryBot.define do
  factory :user do
    name                  { 'Kerry Grant' }
    email                 { 'kerry@example.com' }
    password              { 'password1234' }
    password_confirmation { 'password1234' }
    sex                   { 0 }
  end
end
