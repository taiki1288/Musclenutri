class HomesController < ApplicationController
    def index

    end

    def new_guest
        user = User.find_or_create_by(email: 'guest@example.com') do |user|
            user.password = SecureRandom.urlsafe_base64
            user.username = 'guest'
        end

        sign_in user
        redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
    end
end
