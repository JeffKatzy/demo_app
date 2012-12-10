class Classroom < ActiveRecord::Base
	has_many :users
	belongs_to :teacher
end
