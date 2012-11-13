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
#  lecture_id             :integer
#

class Question < ActiveRecord::Base
	attr_accessible :name, :description, :soundfile, :soundfile_file_name, :answer

	default_scope :order => :id

	belongs_to :lecture

	def next_in_lecture
		self.lecture.questions.where("#{self.class.table_name}.id > ?", self.id).first
    end

    def previous_in_lecture
    	self.lecture.questions.where("#{self.class.table_name}.id < ?", self.id).last
    end

	has_attached_file :soundfile,
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :path => "/:id/:filename"
end
