# == Schema Information
#
# Table name: user_lectures
#
#  id         :integer          not null, primary key
#  lecture_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

require 'test_helper'

class UserLectureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
