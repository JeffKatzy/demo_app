# == Schema Information
#
# Table name: lectures
#
#  id                     :integer          not null, primary key
#  lesson_id              :integer
#  name                   :string(255)
#  description            :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  soundfile_file_name    :string(255)
#  soundfile_content_type :string(255)
#  soundfile_file_size    :integer
#  soundfile_updated_at   :datetime
#

require 'spec_helper'

describe Lecture do
  let(:lecture) { FactoryGirl.create(:lecture) }

  it "has has many questions" do
    lecture.questions.count.should eq 3
  end

  it "has questions assigned in the right order" do
    lecture.questions.first.answer.should eq 1
  end
end
