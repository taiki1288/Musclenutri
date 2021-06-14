class UnfollowsController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def show
        user = User.find(params[:user_id])
        follow_status = current_user.has_followed?(user)
        render json: { hasFollowed: follow_status }
    end

    def create
        user = User.find(params[:user_id])
        current_user.unfollow!(user)
        render json: { status: 'ok' }
    end
end