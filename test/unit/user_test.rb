# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  email        :string(255)
#  cell_number  :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  lecture_id   :integer
#  question_id  :integer
#  classroom_id :integer
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
