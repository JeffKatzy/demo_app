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
	attr_accessible :name, :email, :password, :password_confirmation, :classrooms_attributes
	has_secure_password
	validates :password, presence: true, length: { minimum: 5}
	validates :password_confirmation, presence: true

	before_save :create_remember_token

	has_many :classrooms
	
	accepts_nested_attributes_for :classrooms

	private
	
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end

end
