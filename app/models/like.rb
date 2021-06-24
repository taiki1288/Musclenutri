# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_likes_on_post_id  (post_id)
#  index_likes_on_user_id  (user_id)
#
class Like < ApplicationRecord
    belongs_to :post
    belongs_to :user
    validates :user_id, presence: true
    validates :post_id, presence: true, uniqueness: { scope: :user_id }

    # LIKED_COLOR = '#ff3366'.freeze
    # UNLIKED_COLOR = '#A0A0A0'.freeze
end
