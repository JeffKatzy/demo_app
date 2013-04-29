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
		name 		{ Faker::Name.name }
		description {Faker::Name.name }
		soundfile_file_name { Faker::Name.name }
		soundfile_content_type { Faker::Name.name }
		soundfile_file_size		{ Faker::Name.name }

		 # after_build do |lecture|
		 # 	[:question_one, :question_two, :question_three].each do |question|
		 # 		lecture.questions << FactoryGirl.build(question, lecture: lecture)
		 # 		end
		 # end
	end
end
