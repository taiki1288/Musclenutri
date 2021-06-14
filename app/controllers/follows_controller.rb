class FollowsController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def show
        user = User.find(params[:user_id])
        follow_status = current_user.has_followed?(user)
        render json: { hasFollowed: follow_status }
    end

    def create
        user = User.find(params[:user_id])
        # binding.pry
        current_user.follow!(user)
        render json: { status: 'ok' }
    end

end