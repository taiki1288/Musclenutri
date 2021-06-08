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
end
