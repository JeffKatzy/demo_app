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

	#scope :recent, lambda {
    #joins(:user_answers).group("user_lectures.id").merge(UserAnswer.recent)
  	#}
  	scope :most_recent, limit(3).order("created_at DESC")

	attr_accessible :lecture_id
	scope :today, where(:correct => true)

	def completed?
		lecture.questions.count == user_answers.count	
	end
end
