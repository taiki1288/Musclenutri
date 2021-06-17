class UsersController < ApplicationController
    def index
        @users = User.all
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
        @keyword = params[:keyword]
        render "index"
    end
end