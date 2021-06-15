class LikesController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def show
        post = Post.find(params[:post_id])
        like_status = current_user.has_liked?(post)
        render json: { hasLiked: like_status }
    end

    def create
        post = Post.find(params[:post_id])
        post.likes.create!(user_id: current_user.id)
        render json: { status: 'ok' }
    end

    def destroy
        post = Post.find(params[:post_id])
        like = post.likes.find_by!(user_id: current_user.id)
        like.destroy!
        render json: { status: 'ok' }
    end
end