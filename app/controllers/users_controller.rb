class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def search
        @users = User.search(params[:keyword])
        @keyword = params[:keyword]
        render "index"
    end
end