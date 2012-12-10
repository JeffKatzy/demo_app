require 'faker'

FactoryGirl.define do
	factory :user_answer do
		name { Faker::Name.name }
	end
end