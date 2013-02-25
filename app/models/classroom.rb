# == Schema Information
#
# Table name: classrooms
#
#  id         :integer          not null, primary key
#  teacher_id :integer
#  name       :string(255)
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Classroom < ActiveRecord::Base
	attr_accessible :name, :number
  has_many :classroom_designations
	has_many :users, :through => :classroom_designations
	belongs_to :teacher
end
