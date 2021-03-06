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
#

class Explanation < ActiveRecord::Base
  belongs_to :question

	has_attached_file :soundfile,
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :path => "/:id/:filename"
end
