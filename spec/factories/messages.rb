FactoryBot.define do
  factory :message do
    user_id { FactoryBot.create(:user).id }
    room_id { FactoryBot.create(:room).id }
    message { Faker::Lorem.word }
  end
end
