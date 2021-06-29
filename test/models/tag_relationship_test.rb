# == Schema Information
#
# Table name: tag_relationships
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  tag_id     :bigint           not null
#
# Indexes
#
#  index_tag_relationships_on_post_id  (post_id)
#  index_tag_relationships_on_tag_id   (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (tag_id => tags.id)
#
require 'test_helper'

class TagRelationshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
