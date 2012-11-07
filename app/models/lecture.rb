class Lecture < ActiveRecord::Base
	attr_accessible :name, :description, :sound_file, :sound_file_file_name

	has_attached_file :sound_file,
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :path => "/:id/:filename"
end
