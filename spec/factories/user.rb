require 'faker'

FactoryGirl.define do
	factory :user do
    association :lecture
		name { Faker::Name.name }
		email { Faker::Internet.email }
		cell_number { "+12154997415" }
	end
end

