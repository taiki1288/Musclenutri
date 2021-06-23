FactoryBot.define do
  factory :review do
    association :user
    association :post
    content { Faker::Lorem.word }
    score { 5 }
  end
end
