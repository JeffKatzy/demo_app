# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  email         :string(255)
#  cell_number   :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  lecture_id    :integer
#  question_id   :integer
#  assignment_id :integer
#

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

describe User do
  before :each do
    @user = FactoryGirl.create(:user).should be_valid
  end

	it "has a valid factory" do
		FactoryGirl.create(:user).should be_valid
	end

  it "belongs to a lecture" do
    user = FactoryGirl.create(:user).should be_valid
  end

  it "has many user_answers" do
  end

  it "has many user_lectures" do
  end

  it "has many classroom designations" do
  end

  it "has many classrooms" do
  end

  it "has many assignments" do
  end
end
