# Read about factories at https://github.com/thoughtbot/factory_girl
# == Schema Information
#
# Table name: explanations
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  description            :text
#  question_id            :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  soundfile_file_name    :string(255)
#  soundfile_content_type :string(255)
#  soundfile_file_size    :integer
#  soundfile_updated_at   :datetime

FactoryGirl.define do
  factory :explanation do
    name "explanation for question one"
    description "what is the explanation here"
  end
end
