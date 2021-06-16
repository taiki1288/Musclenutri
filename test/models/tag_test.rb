# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  tag_name   :string(191)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_tag_name  (tag_name) UNIQUE
#
require "test_helper"

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
