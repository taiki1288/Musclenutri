class LikesController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def show
        post = Post.find(params[:post_id])
        like_status = current_user.has_liked?(post)
        like_count = post.like_counts(post)
        render json: { hasLiked: like_status, likeCounts: like_count }
    end

    def create
        post = Post.find(params[:post_id])
        post.likes.create!(user_id: current_user.id)
        post.create_notification_like!(current_user)
        like_count = post.like_counts(post)
        render json: { status: 'ok', likeCounts: like_count }
    end

    def destroy
        post = Post.find(params[:post_id])
        like = post.likes.find_by!(user_id: current_user.id)
        like.destroy!
        like_count = post.like_counts(post)
        render json: { status: 'ok', likeCounts: like_count }
    end
end