class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
        @users = User.all.page(params[:page])
    end

    def show
        @user = User.find(params[:id])
        reviews = Review.where(user_id: current_user.id).pluck(:post_id)
        @reviews = Post.find(reviews)
        review_list = Review.where(user_id: @user.id).pluck(:post_id)
        @review_list = Post.find(review_list)
        if user_signed_in?
            @currentUserEntry = Entry.where(user_id: current_user.id)
            @userEntry = Entry.where(user_id: @user.id)
            unless @user.id == current_user.id
                @currentUserEntry.each do |cu|
                    @userEntry.each do |u|
                        if cu.room_id == u.room_id
                            @haveRoom = true
                            @roomId = cu.room_id
                        end
                    end
                end
                unless @haveRoom
                    @room = Room.new
                    @entry = Entry.new
                end
            end
        end
    end

    def search
        @users = User.search(params[:keyword])
        @users = @users.page(params[:page]).per(12)
        @keyword = params[:keyword]
        render 'index'
    end

    def followers
        @user = User.find(params[:id])
        @users = @user.followers.page(params[:page])
    end

    def following
        @user = User.find(params[:id])
        @users = @user.followings.page(params[:page])
    end
end
