require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '正常値と異常値の確認' do
    let(:like) { create(:like) }
    
    context 'likeモデルのバリデーション' do

      it 'user_idとpost_idがあれば保存される' do
        expect(like).to be_valid
      end

      it 'user_idがなければ保存されない' do 
        like.user_id = nil
        like.valid?
        expect(like.errors[:user_id]).to include("を入力してください")
      end

      it 'post_idがなければ保存されない' do
        like.post_id = nil
        like.valid?
        expect(like.errors[:post_id]).to include("を入力してください")
      end

      it 'post_idが同じでもuser_idが違うと保存できる' do
        like = FactoryBot.create(:like)
        expect(FactoryBot.create(:like, post_id: like.post_id)).to be_valid
      end

      it 'user_idが同じでもpost_idが違うと保存できる' do
        like = FactoryBot.create(:like)
        expect(FactoryBot.create(:like, user_id: like.user_id)).to be_valid
      end

    end

  end
end
