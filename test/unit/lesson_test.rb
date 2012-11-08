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

require 'test_helper'

class LessonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
