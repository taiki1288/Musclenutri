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
    end

    def search
        @users = User.search(params[:keyword])
        @keyword = params[:keyword]
        render "index"
    end
end