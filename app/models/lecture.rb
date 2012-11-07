class Lecture < ActiveRecord::Base
	has_attached_file :sound_file,
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :path => "/:id/:filename"
end
