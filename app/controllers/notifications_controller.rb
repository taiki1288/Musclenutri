class NotificationsController < ApplicationController
    before_action :authenticate_user!

    def index
        @notifications = current_user.passive_notifications.includes([:post, :visitor, :visited])
    end

    def destroy
        @notifications = current_user.passive_notifications.destroy_all
        redirect_to notifications_path
    end
end
