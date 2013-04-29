# == Schema Information
#
# Table name: questions
#
#  id                           :integer          not null, primary key
#  lesson_id                    :integer
#  name                         :string(255)
#  description                  :text
#  answer                       :integer
#  created_at                   :datetime
#  updated_at                   :datetime
#  soundfile_file_name          :string(255)
#  soundfile_content_type       :string(255)
#  soundfile_file_size          :integer
#  soundfile_updated_at         :datetime
#  lecture_id                   :integer
#  explanationfile_file_name    :string(255)
#  explanationfile_content_type :string(255)
#  explanationfile_file_size    :integer
#  explanationfile_updated_at   :datetime

require 'faker'


FactoryGirl.define do
	factory :question do
		association :lecture
		name 		{ Faker::Lorem.words(1) }
		description { Faker::Lorem.words(7) }

		factory :question_one do
			answer	1
		end

		factory :question_two do
			answer 2
		end

		factory :question_three do
			answer 3
		end
	end
end