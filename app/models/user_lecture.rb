# == Schema Information
#
# Table name: user_lectures
#
#  id            :integer          not null, primary key
#  lecture_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  end_time      :datetime
#  assignment_id :integer
#

class UserLecture < ActiveRecord::Base
	has_many :user_answers
	belongs_to :user
	belongs_to :lecture
  default_scope order('created_at DESC')
  attr_accessible :end_time
  belongs_to :assignment
  scope :correct, where(:correct => true)
  scope :today, lambda { where("created_at > ?", 1.day.ago) }
  scope :current, lambda { where("created_at > ?", 1.hour.ago) }

	attr_accessible :lecture_id

	def completed?
		lecture.questions.count == user_answers.count
	end

  def number_incomplete
    lecture.questions.count - user_answers.count
  end
end
