FactoryBot.define do
  factory :item do
    name { Faker::Camera.model }
    description { "Generated description" }
    unit_price { 1.5 }
    merchant
  end
end
