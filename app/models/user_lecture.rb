# == Schema Information
#
# Table name: user_lectures
#
#  id         :integer          not null, primary key
#  lecture_id :integer
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class UserLecture < ActiveRecord::Base
	has_many :user_answers
	belongs_to :user
	belongs_to :lecture

	attr_accessible :lecture_id
end
