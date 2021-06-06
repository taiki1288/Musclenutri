class PostsController < ApplicationController
    before_action :authenticate_user!, only:[:new, :create, :edit, :destory]

    def index
        @posts = Post.all
    end

    def new
        @post = current_user.posts.build
    end

end
