class PostsController < ApplicationController
    before_action :authenticate_user!, only:[:new, :create, :edit, :destory]

    def index
        @posts = Post.all
        @post_ranks = Post.create_all_ranks
        @tag_list = Tag.all
        @tag_ranks = Tag.find(TagRelationship.group(:tag_id).order(Arel.sql('count(tag_id)desc')).limit(20).pluck(:tag_id))
    end

    def show
        @post = Post.find(params[:id])
        @review = Review.new
        @post_tags = @post.tags
    end

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)
        tag_list = params[:post][:tag_name].split(nil)
        if @post.save!
          @post.save_tags(tag_list)
          redirect_to root_path, notice: '投稿が完了しました。'
        else
          render :new, notice: '投稿に失敗しました。'
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

    def destory
        post = current_user.posts.find(params[:id])
        post.destory!
        redirect_to root_path
    end

    def tags
        @tag_list = Tag.all
        @tag = Tag.find(params[:tag_id])
        @posts = @tag.posts.all
    end

    private
    def post_params
        params.require(:post).permit(:name, :content, :price, :image).merge(user_id: current_user.id)
    end
end
