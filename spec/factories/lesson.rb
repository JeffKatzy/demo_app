# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime

require 'faker'

FactoryGirl.define do
	factory :lesson do
		name 		{Faker::Lorem.words(1)}
		description {Faker::Lorem.words(7)}
	end
end