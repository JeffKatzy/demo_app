# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  lecture_id  :integer
#  question_id :integer
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Lesson < ActiveRecord::Base
	attr_accessible :name, :description, :lecture_id, :question_id

	has_many :lectures
	has_many :questions
end
