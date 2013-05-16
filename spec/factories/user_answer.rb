# == Schema Information
#
# Table name: user_answers
#
#  id              :integer          not null, primary key
#  question_id     :integer
#  user_id         :integer
#  value           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  correct         :boolean
#  user_lecture_id :integer
#

require 'faker'

FactoryGirl.define do
  factory :user_answer do
    factory :answer_one do
      association :question
      association :user
      association :user_lecture
      value 1
    end

    factory :answer_two do
      association :question
      association :user
      association :user_lecture
      value 1
    end

    factory :answer_three do
      association :question
      association :user
      association :user_lecture
      value 1
    end
  end
end