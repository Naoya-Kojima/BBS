FactoryBot.define do
  factory :post do
    title     { "example_title" }
    content   { "example_content" }
    user_id   { 1 }
  end
end
