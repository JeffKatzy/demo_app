# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  email       :string(255)
#  cell_number :string(255)
#  lesson_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class User < ActiveRecord::Base
	attr_accessible :name, :email, :cell_number
	after_create :initialize_lesson

	has_many :calls

	def initialize_lesson
      self.recorded_lesson_id ||= 
        if Lesson.first
            Lesson.first.id
        else
          nil
        end
    end
end
