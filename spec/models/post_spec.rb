require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    let(:post) { create(:post) }

    context '投稿が保存されている場合' do

      it 'name,content,priceが入力されていれば投稿が保存される' do
        expect(post).to be_valid
      end

      it 'nameが30文字以内で入力されていれば保存される' do
        post = build(:post, name: Faker::Lorem.characters(number: 30))
        expect(post).to be_valid
      end

      it 'contentが300文字以内で入力されていれば保存される' do 
        post = build(:post, content: Faker::Lorem.characters(number: 300))
        expect(post).to be_valid
      end
    end

    context '投稿が保存されない場合' do

      it 'nameが入力されていないと保存されない' do
        post = build(:post, name: nil)
        post.valid?
        expect(post.errors[:name]).to include("を入力してください")
      end

      it 'nameが31文字以上の場合保存できない' do
        post = build(:post, name: Faker::Lorem.characters(number: 31))
        post.valid?
        expect(post.errors[:name]).to include("は30文字以内で入力してください")
      end

      it 'cotentが入力されていないと保存できない' do
        post = build(:post, content: nil)
        post.valid?
        expect(post.errors[:content]).to include("を入力してください")
      end

      it 'contentが301文字以上入力されていると保存できない' do
        post = build(:post, content: Faker::Lorem.characters(number: 301))
        post.valid?
        expect(post.errors[:content]).to include("は300文字以内で入力してください")
      end

      it 'priceが入力されていないと保存できない' do
        post = build(:post, price: nil)
        post.valid?
        expect(post.errors[:price]).to include("を入力してください")
      end

    end

  end
end
