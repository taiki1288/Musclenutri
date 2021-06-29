# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_reviews_on_post_id  (post_id)
#  index_reviews_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '#create' do
    let(:review) { create(:review) }

    context 'レビューが保存される場合' do

      it 'content, scoreが入力されていれば保存される' do
        expect(review).to be_valid
      end

      it 'contentが150文字以内に入力されていれば保存される' do
        review = build(:review, content: Faker::Lorem.characters(number: 150))
        expect(review).to be_valid
      end

    end

    context 'レビューが保存されない場合' do

      it 'contentが入力されていないと保存されない' do
        review = build(:review, content: nil)
        review.valid?
        expect(review.errors[:content]).to include('を入力してください')
      end

      it 'contentが151文字以上の場合保存できない' do
        review = build(:review, content: Faker::Lorem.characters(number: 151))
        review.valid?
        expect(review.errors[:content]).to include('は150文字以内で入力してください')
      end

    end
  end
end
