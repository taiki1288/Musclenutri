class FollowsController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def show
        user = User.find(params[:user_id])
        follow_status = current_user.has_followed?(user)
        follower_count = user.follower_counts(user)
        following_count = user.following_counts(user)
        render json: { hasFollowed: follow_status, followerCounts: follower_count, followingCounts: following_count }
    end

    def create
        user = User.find(params[:user_id])
        current_user.follow!(user)
        user.create_notification_follow!(current_user)
        follower_count = user.follower_counts(user)
        following_count = user.following_counts(user)
        render json: { status: 'ok', followerCounts: follower_count, followingCounts: following_count }
    end

end
