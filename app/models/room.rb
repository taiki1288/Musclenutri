# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Room < ApplicationRecord
    has_many :messages
    has_many :entries
    has_many :users, through: :entries
end
