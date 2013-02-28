# == Schema Information
#
# Table name: explanations
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  description            :text
#  question_id            :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  soundfile_file_name    :string(255)
#  soundfile_content_type :string(255)
#  soundfile_file_size    :integer
#  soundfile_updated_at   :datetime
#

require 'test_helper'

class ExplanationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
