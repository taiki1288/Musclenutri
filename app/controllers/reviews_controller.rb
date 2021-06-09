class ReviewsController < ApplicationController

    def index
        @post = Post.find(params[:post_id])
        @reviews = @post.reviews
    end

    def create
        post = Post.find(params[:post_id])
        @review = post.reviews.build(review_params)
        if @review.save!
            redirect_to post_reviews_path(@review), notice: 'レビューが完了しました。'
        else
            render post_path, notice: 'レビューに失敗しました。'
        end
    end

    private
    def review_params
        params.require(:review).permit(:content, :score).merge(user_id: current_user.id)
    end

end