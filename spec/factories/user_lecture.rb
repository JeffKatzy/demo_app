# == Schema Information
#
# Table name: user_lectures
#
#  id            :integer          not null, primary key
#  lecture_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  end_time      :datetime
#  assignment_id :integer
#


require 'faker'

FactoryGirl.define do
  factory :user_lecture do
    association :lecture
    association :user
    association :assignment
  end
end


