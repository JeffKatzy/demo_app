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

require 'spec_helper'

describe Lesson do
  let(:lesson) { FactoryGirl.create(:lesson) }

  it "has has many lectures" do
    lesson.lectures.count.should eq 2
  end
end
