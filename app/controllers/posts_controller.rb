class PostsController < ApplicationController
    before_action :authenticate_user!, only:[:new, :create, :edit, :destory]

    def index
        @posts = Post.all
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save!
          redirect_to post_path(@post)
        else
          render :new
        end
    end

    def edit
        @post = current_user.posts.find(params[:id])
    end

    def update
        @post = current_user.posts.find(params[:id])
        if @post.update(post_params)
            redirect_to post_path(@post)
        else
            render :new
        end
    end

    private
    def post_params
        params.require(:post).permit(:name, :content, :price, :image).merge(user_id: current_user.id)
    end
end
