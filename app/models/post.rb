# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  name       :string(255)      not null
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
    belongs_to :user
    has_many :reviews, dependent: :destroy

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
end
