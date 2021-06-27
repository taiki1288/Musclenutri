# == Schema Information
#
# Table name: relationships
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  follower_id  :bigint           not null
#  following_id :bigint           not null
#
# Indexes
#
#  index_relationships_on_follower_id   (follower_id)
#  index_relationships_on_following_id  (following_id)
#
# Foreign Keys
#
#  fk_rails_...  (follower_id => users.id)
#  fk_rails_...  (following_id => users.id)
#
require 'rails_helper'

RSpec.describe Relationship, type: :model do 
  let(:relationship) { FactoryBot.create(:relationship) }
  describe '#create' do
    context '保存できる場合' do
      it '全てのパラメーターが揃っていれば保存できる' do
        expect(relationship).to be_valid
      end
    end

    context '保存できない場合' do

      it 'follower_idがnilの場合は保存できない' do
        relationship.follower_id = nil
        relationship.valid?
        expect(relationship.errors[:follower_id]).to include("を入力してください")
      end

      it 'following_idがnilの場合は保存できない' do
        relationship.following_id = nil
        relationship.valid?
        expect(relationship.errors[:following_id]).to include("を入力してください")
      end

    end

    context '一意性の検証' do
      before do
        @relation = FactoryBot.create(:relationship)
        @user1 = FactoryBot.build(:relationship)
      end

      it 'follower_idとfolowing_idの組み合わせは一意でないといけない' do
        relation2 = FactoryBot.build(:relationship, follower_id: @relation.follower_id, following_id: @relation.following_id)
        relation2.valid?
        expect(relation2.errors[:follower_id]).to include("はすでに存在します")
      end

      it 'follower_idが同じでもfollowing_idが違うなら保存できる' do
        relation2 = FactoryBot.build(:relationship, follower_id: @relation.follower_id, following_id: @user1.following_id)
        expect(relation2).to be_valid
      end

      it 'follower_idが違うならfollowing_idが同じでも保存できる' do
        relation2 = FactoryBot.build(:relationship, follower_id: @user1.follower_id, following_id: @relation.following_id)
        expect(relation2).to be_valid
      end

      describe '各モデルとのアソシエーション' do
        let(:association) do
          described_class.reflect_on_association(target)
        end

        context '仮装モデルfollowerとのアソシエーション' do
          let(:target) { :follower }

          it 'followerとの関連付けはbelongs_toであること' do
            expect(association.macro).to eq :belongs_to
          end
        end
        
        context '仮装モデルとfollowingのアソシエーション' do
          let(:target) { :following }

          it 'followingとの関連付けはbelongs_toであること' do
            expect(association.macro).to eq :belongs_to
          end
        end

      end

    end
  end
end
