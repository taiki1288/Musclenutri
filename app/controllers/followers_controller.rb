class FollowersController < ApplicationController
    before_action :authenticate_user!

    def index
        @user = User.find(params[:user_id])
        @followes = @user.followers
    end
    
end