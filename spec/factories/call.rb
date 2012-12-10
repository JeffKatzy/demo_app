require 'faker'

FactoryGirl.define do
	factory :call do
		name 		{Faker::Lorem.words(1)}
		description {Faker::Lorem.words(7)}
		soundfile_file_name {Faker::Lorem.words(1)}
		soundfile_content_type {Faker::Lorem.words(3)}
		soundfile_file_size		{Faker::Lorem.words(8)}
	end
end