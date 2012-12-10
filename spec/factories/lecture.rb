# Table name: lectures
#
#  id                     :integer          not null, primary key
#  lesson_id              :integer
#  name                   :string(255)
#  description            :text
#  created_at             :datetime
#  updated_at             :datetime
#  soundfile_file_name    :string(255)
#  soundfile_content_type :string(255)
#  soundfile_file_size    :integer
#  soundfile_updated_at   :datetime

require 'faker'

FactoryGirl.define do
	factory :lecture do
		#association :question
		name 		{Faker::Lorem.words(1)}
		description {Faker::Lorem.words(7)}
		soundfile_file_name {Faker::Lorem.words(1)}
		soundfile_content_type {Faker::Lorem.words(3)}
		soundfile_file_size		{Faker::Lorem.words(8)}

		after(:build) do |question|
			[:question_one, :question_two, :question_three].each do |question|
				lecture.questions << FactoryGirl.build(question, lecture: lecture)
			end
		end
	end
end
