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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
