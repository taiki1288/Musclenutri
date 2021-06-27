# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  message    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_messages_on_room_id  (room_id)
#  index_messages_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    let(:message) { create(:message) }

    context 'メッセージが保存される場合' do
      it 'message, user_id, room_idがある場合に保存される' do
        expect(message).to be_valid
      end

      it 'messageが150文字以内の場合保存される' do
        message = build(:message, message: Faker::Lorem.characters(number: 150))
        expect(message).to be_valid
      end
    end

    context 'メッセージが保存されない場合' do

      it 'messageの内容がnilだった場合保存されない' do
        message = build(:message, message: nil)
        message.valid?
        expect(message.errors[:message]).to include("を入力してください")
      end

      it 'messageの内容が151文字以上の場合保存されない' do
        message = build(:message, message: Faker::Lorem.characters(number: 151))
        message.valid?
        expect(message.errors[:message]).to include("は150文字以内で入力してください")
      end

      it 'user_idがnilの場合は保存できない' do
        message.user_id = nil
        message.valid?
        expect(message.errors[:user_id]).to include("を入力してください")
      end

      it 'room_idがnilの場合は保存できない' do
        message.room_id = nil
        message.valid?
        expect(message.errors[:room_id]).to include("を入力してください")
      end

    end 

  end
end
