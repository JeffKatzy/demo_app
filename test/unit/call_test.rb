# == Schema Information
#
# Table name: calls
#
#  id          :integer          not null, primary key
#  to          :string(255)
#  from        :string(255)
#  called      :string(255)
#  account_sid :string(255)
#  call_sid    :string(255)
#  call_status :string(255)
#  caller      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  state       :string(255)
#

require 'test_helper'

class CallTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
