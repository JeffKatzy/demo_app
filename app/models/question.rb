# == Schema Information
#
# Table name: questions
#
#  id                     :integer          not null, primary key
#  lesson_id              :integer
#  name                   :string(255)
#  description            :text
#  answer                 :integer
#  created_at             :datetime
#  updated_at             :datetime
#  soundfile_file_name    :string(255)
#  soundfile_content_type :string(255)
#  soundfile_file_size    :integer
#  soundfile_updated_at   :datetime
#

class Question < ActiveRecord::Base
	attr_accessible :name, :description, :soundfile, :soundfile_file_name, :answer

	belongs_to :lecture

	has_attached_file :soundfile,
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :path => "/:id/:filename"
end
