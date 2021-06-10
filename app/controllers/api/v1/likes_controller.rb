module Api 
    module V1 
        class LikesController < ApplicationController
            skip_forgery_protection

            def create
                like = Like.create!(user: current_user, post_id: params[:post_id] )
                render json: { like_id: like.id }
            end

            def destory
                Like.find(params[:id]).destroy!
                render json: { }
            end
            
        end
    end
end