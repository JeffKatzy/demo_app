# == Schema Information
#
# Table name: teachers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Teacher < ActiveRecord::Base
	attr_accessible :name, :email, :classrooms_attributes

	has_many :classrooms

	accepts_nested_attributes_for :classrooms
end
