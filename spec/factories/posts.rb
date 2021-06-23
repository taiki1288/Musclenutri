FactoryBot.define do
  factory :post do
    association :user
    name { Faker::Lorem.word }
    content { Faker::Lorem.word }
    price { '5000' }
  end
end
