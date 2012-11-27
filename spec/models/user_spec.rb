# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  email       :string(255)
#  cell_number :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  lecture_id  :integer
#  question_id :integer
#

require 'spec_helper'

describe Contact do
	it "has a valid factory" do
		FactoryGirl.create(:user).should be_valid
	end
end
