class ReviewsController < ApplicationController
    before_action :authenticate_user!

    def index
        @post = Post.find(params[:post_id])
        @reviews = @post.reviews
    end

    def create
        post = Post.find(params[:post_id])
        @review = post.reviews.build(review_params)
        @post = @review.post
        if @review.save!
            @post.create_notification_review!(current_user, @review.id)
            redirect_to post_reviews_path(@review.post), notice: 'レビューが完了しました。'
        else
            render post_path, notice: 'レビューに失敗しました。'
        end
    end

    private
    def review_params
        params.require(:review).permit(:content, :score).merge(user_id: current_user.id)
    end

end
