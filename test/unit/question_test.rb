# == Schema Information
#
# Table name: questions
#
#  id                     :integer          not null, primary key
#  lesson_id              :integer
#  name                   :string(255)
#  description            :text
#  answer                 :integer
#  created_at             :datetime
#  updated_at             :datetime
#  soundfile_file_name    :string(255)
#  soundfile_content_type :string(255)
#  soundfile_file_size    :integer
#  soundfile_updated_at   :datetime
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
