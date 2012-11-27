# == Schema Information
#
# Table name: explanations
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  description            :text
#  question_id            :integer
#  created_at             :datetime
#  updated_at             :datetime
#  soundfile_file_name    :string(255)
#  soundfile_content_type :string(255)
#  soundfile_file_size    :integer
#  soundfile_updated_at   :datetime
#

require 'faker'

FactoryGirl.define do 
	factory :user do
		name { Faker::Name.name}
		email { Faker::Internet.email}
		cell_number { "+12154997415"}
	end
