require 'spec_helper'

require 'faker'

FactoryGirl.define do 
	factory :user do
		name { Faker::Name.name}
		email { Faker::Internet.email}
		cell_number { "+12154997415"}
	end
end

