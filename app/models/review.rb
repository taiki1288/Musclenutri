# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_reviews_on_post_id  (post_id)
#  index_reviews_on_user_id  (user_id)
#
class Review < ApplicationRecord
    belongs_to :user
    belongs_to :post
    has_many :notifications, dependent: :destroy
    validates :score, presence: true
    validates :content, presence: true, length: { maximum: 150 }
end
