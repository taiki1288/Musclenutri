require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe '#create' do
    let(:entry) { create(:entry) }

    context 'entryが保存される場合' do
      it 'user_id,room_idが保存される' do
        expect(entry).to be_valid
      end
    end

    context 'entryが保存されない場合' do

      it 'user_idが入力されていないと保存されない' do
        entry = build(:entry, user_id: nil)
        entry.valid?
        expect(entry.errors[:user_id]).to include("を入力してください")
      end

      it 'room_idがない場合保存されない' do
        entry = build(:entry, room_id: nil)
        entry.valid?
        expect(entry.errors[:room_id]).to include("を入力してください")
      end

    end

    context '一意性の検証' do

      it 'user_idとroom_idの組み合わせは一意でないといけない' do
        entry2 = build(:entry, user_id: entry.user_id, room_id: entry.room_id)
        entry2.valid?
        expect(entry2.errors[:room_id]).to include("はすでに存在します")
      end

      it 'room_idが同じでもuser_idが違うなら保存できる' do
        user2 = FactoryBot.build(:user)
        entry2 = build(:entry, user_id: user2.id, room_id: entry.room_id)
        expect(entry).to be_valid
      end

      it 'room_idが違うならuser_idが同じでも保存できる' do
        room2 = FactoryBot.build(:room)
        entry2 = build(:entry, user_id: entry.user_id, room_id: room2.id)
        expect(entry).to be_valid
      end
    end

      describe '各モデルとのアソシエーション' do
        let(:association) do
          described_class.reflect_on_association(target)
        end

        context 'userモデルとのアソシエーション' do
          let(:target) { :user }

          it 'userとの関連付けはbelongs_toであること' do
            expect(association.macro).to eq :belongs_to
          end
        end
        
        context 'roomモデルとのアソシエーション' do
          let(:target) { :room }

          it 'roomとの関連付けはbelongs_toであること' do
            expect(association.macro).to eq :belongs_to
          end
        end

      end
  end
end
