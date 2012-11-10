# == Schema Information
#
# Table name: user_answers
#
#  id             :integer          not null, primary key
#  question_id    :integer
#  user_id        :integer
#  explanation_id :integer
#  value          :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require 'test_helper'

class UserAnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
