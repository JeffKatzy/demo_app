# == Schema Information
#
# Table name: user_answers
#
#  id              :integer          not null, primary key
#  question_id     :integer
#  user_id         :integer
#  value           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
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
	scope :recent, lambda { where("created_at > ?", 1.day.ago) }

	def self.grade
		if percentage_correct == "no answers"
			"no answers"
		elsif percentage_correct > 66.66
			"mastered"
		elsif percentage_correct.between?(33.33, 66.66) 
			"passed"
		else
			"failed"
		end
	end


	def self.percentage_correct
		if count == 0
			"no answers"
		else
			(correct.count.to_f / count)*100
		end
	end

	def self.percentage_incorrect
		if count == 0
			"no answers"
		else 
			(incorrect.count.to_f / count.to_f)*100
		end
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
