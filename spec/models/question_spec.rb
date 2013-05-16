# == Schema Information
#
# Table name: questions
#
#  id                           :integer          not null, primary key
#  name                         :string(255)
#  description                  :text
#  answer                       :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  soundfile_file_name          :string(255)
#  soundfile_content_type       :string(255)
#  soundfile_file_size          :integer
#  soundfile_updated_at         :datetime
#  lecture_id                   :integer
#  explanationfile_file_name    :string(255)
#  explanationfile_content_type :string(255)
#  explanationfile_file_size    :integer
#  explanationfile_updated_at   :datetime
#

require 'spec_helper'

describe Question do
  let(:question) { FactoryGirl.create(:question) }
  let(:explanation){ FactoryGirl.create(:explanation) }

  it "has one explanation" do
    question.explanation = explanation
    question.explanation.should eq explanation
  end
end
