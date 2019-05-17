FactoryBot.define do
  factory :comment do
    content { 'Hello, World' }
    user_id { 1 }
    post_id { 1 }
  end
end
