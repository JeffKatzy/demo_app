# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Lesson < ActiveRecord::Base
	attr_accessible :name, :description, :lecture_id, :question_id

	has_many :lectures
	has_many :questions
end
