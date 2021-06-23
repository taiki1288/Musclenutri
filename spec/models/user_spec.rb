require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    context 'ユーザー登録ができる場合' do
      let!(:user) { create(:user) }

      it 'email, password, usernameが入力されれば登録できる' do
        expect(user).to be_valid
      end

      it 'ユーザーネームが15文字以内だと保存できること' do
        user = build(:user, username: 'a' * 15)
        expect(user).to be_valid
      end

    end

    context 'ユーザーが登録できない場合' do
      let!(:user) { create(:user) }

      it 'ユーザーネームが入力されていないと登録できない' do
        user = build(:user, username: nil)
        user.valid?
        expect(user.errors[:username]).to include("を入力してください")
      end

      it 'emailが入力されていないと登録できない' do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it 'passwordが入力されていないと登録できない' do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it 'パスワードとパスワード確認が一致していないと登録できない' do
        user = build(:user, password: 'password', password_confirmation: nil)
        user.valid?
        expect(user.errors[:password_confirmation]).to include("を入力してください")
      end

      it 'emailがすでに存在して重なった場合' do
        user = create(:user)
        user2 = build(:user, email: user.email)
        user2.valid?
        expect(user2.errors[:email]).to include("はすでに存在します")
      end

      it 'パスワードが6文字以下だと登録できない' do
        user = build(:user, password: 'a' * 5 )
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end

      it 'ユーザーネームが15文字以上だと登録できない' do
        user = build(:user, username: 'a' *16)
        user.valid?
        expect(user.errors[:username]).to include("は15文字以内で入力してください")
      end

    end
  end
end
