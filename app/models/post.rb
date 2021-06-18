# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  name       :string(191)      not null
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
class Post < ApplicationRecord
    has_one_attached :image
    has_one_attached :avatar
    belongs_to :user
    has_many :reviews, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :tag_relationships, dependent: :destroy
    has_many :tags, through: :tag_relationships
    has_many :notifications, dependent: :destroy


    def avg_score
        unless self.reviews.empty?
          reviews.average(:score).round(1).to_f
        else
          0.0
        end
      end
    
      def review_score_percentage
        unless self.reviews.empty?
          reviews.average(:score).round(1).to_f*100/5
        else
          0.0
        end
    end

    def like_by(user)
        likes.where(likes: { user_id: user }).last
    end
    
    def liked_by?(user)
        like_by(user).present?
    end

    def save_tags(savepost_tags)
        current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
        old_tags = current_tags - savepost_tags
        new_tags = savepost_tags - current_tags
        old_tags.each do |old|
            self.tags.delete Tag.find_by(tag_name: old)
        end
        new_tags.each do |new|
            new_post_tag = Tag.find_or_create_by(tag_name: new)
            self.tags << new_post_tag
        end
    end

    def like_counts(post)
       likes.count
    end
    
    def self.create_all_ranks
      Post.find(Like.group(:post_id).order('count(post_id) desc').limit(4).pluck(:post_id))
    end

    def self.create_review_ranks
      Post.find(Review.group(:post_id).order('avg(score) desc').limit(4).pluck(:post_id))
    end

    def create_notification_review!(current_user, review_id)
      temp_ids = Review.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
      temp_ids.each do |temp_id|
        save_notification_review!(current_user, review_id, temp_id['user_id'])
      end
      save_notification_review!(current_user, review_id, user_id) if temp_ids.blank?
    end

    def save_notification_review!(current_user, review_id, visited_id)
      notification = current_user.active_notifications.new(
        post_id: id,
        review_id: review_id,
        visited_id: visited_id,
        action: 'review'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end

    def create_notification_like!(current_user)
      temp = Notification.where(['visitor_id = ? and visited_id = ? and post_id = ? and action = ? ', current_user.id, user_id, id, 'like'])
      if temp.blank?
        notification = current_user.active_notifications.new(
          post_id: id,
          visited_id: user_id,
          action: 'like'
        )
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
    end

end
