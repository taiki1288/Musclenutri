class LikesController < ApplicationController
    before_action :authenticate_user!

    def show
        @post = Post.params[:post_id]
        like_status = current_user.

    end
end