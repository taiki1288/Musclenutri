# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  action     :string(191)      default(""), not null
#  checked    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :integer
#  post_id    :integer
#  review_id  :integer
#  room_id    :integer
#  visited_id :integer          not null
#  visitor_id :integer          not null
#
# Indexes
#
#  index_notifications_on_post_id     (post_id)
#  index_notifications_on_review_id   (review_id)
#  index_notifications_on_visited_id  (visited_id)
#  index_notifications_on_visitor_id  (visitor_id)
#
require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe '#create' do
    context 'レビュー関連の通知' do
      before do
        @post = FactoryBot.build(:post)
        @message = FactoryBot.build(:message)
      end

      it 'レビューが行われた時に保存できる' do
        notification = FactoryBot.build(:notification, post_id: @post.id, action: 'review')
        expect(notification).to be_valid
      end

      it '投稿にいいねが行われた時に保存できる' do
        notification = FactoryBot.build(:notification, post_id: @post.id, action: 'like')
        expect(notification).to be_valid
      end

      it 'メッセージが行われた時に保存できる' do
        notification = FactoryBot.build(:notification, message_id: @message.id)
        expect(notification).to be_valid
      end

    end

    context 'フォロー関連の通知' do

      it 'フォローが行われた場合に保存できる' do
        user1 = FactoryBot.build(:user)
        user2 = FactoryBot.build(:user)
        notification = FactoryBot.build(:notification, visitor_id: user1.id, visited_id: user2.id, action: 'follow')
        expect(notification).to be_valid
      end

    end

    describe 'アソシエーションのテスト' do
      let(:association) do
        described_class.reflect_on_association(target)
      end

      context 'postモデルとのアソシエーション' do
        let(:target) { :post }

        it 'postとの関連付けはbelongs_toであること' do
          expect(association.macro).to eq :belongs_to
        end

      end

      context 'reviewモデルとのアソシエーション' do
        let(:target) { :review }

        it 'reviewとの関連付けはbelons_toであること' do
          expect(association.macro).to eq :belongs_to
        end

      end

      context 'messageモデルとのアソシエーション' do
        let(:target) { :message }

        it 'messageとの関連付けはbelons_toであること' do
          expect(association.macro).to eq :belongs_to
        end

      end

      context 'visitorとのアソシエーション' do
        let(:target) { :visitor }
        it 'visitorとの関連付けはbelongs_toであること' do
          expect(association.macro).to eq :belongs_to
        end

      end

      context 'visitedとのアソシエーション' do
        let(:target) { :visited }
        it 'visitedとの関連付けはbelongs_toであること' do
          expect(association.macro).to eq :belongs_to
        end

      end

    end

  end
end
