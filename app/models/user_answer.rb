# == Schema Information
#
# Table name: user_answers
#
#  id              :integer          not null, primary key
#  question_id     :integer
#  user_id         :integer
#  value           :integer
#  created_at      :datetime
#  updated_at      :datetime
#  correct         :boolean
#  user_lecture_id :integer
#

class UserAnswer < ActiveRecord::Base
	belongs_to :user
	belongs_to :user_lecture
	validates :user_id, presence: true
	attr_accessible :value, :question_id, :correct, :user_lecture_id

	scope :incorrect, where(:correct => false)
	scope :correct, where(:correct => true)


	def self.percentage_correct
		(correct.count.to_f / count.to_f)*100
	end

	def self.percentage_incorrect
		(incorrect.count.to_f / count.to_f)*100
	end

	def lecture_names #for grouping multiple lectures
		group_by { |a| a.lecture.name }
	end

	def lecture
		question.lecture
	end



	def question
		Question.find(question_id)
	end

	def correct?
		value == question.answer
	end

	def assert_correct
		if correct?
			self[:correct] = 1
		else
			self[:correct] = 0
		end
	end
end
