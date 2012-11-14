# == Schema Information
#
# Table name: user_answers
#
#  id          :integer          not null, primary key
#  question_id :integer
#  user_id     :integer
#  value       :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class UserAnswer < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
	attr_accessible :value, :question_id
end
