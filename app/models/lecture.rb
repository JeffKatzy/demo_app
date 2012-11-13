# == Schema Information
#
# Table name: lectures
#
#  id                     :integer          not null, primary key
#  lesson_id              :integer
#  name                   :string(255)
#  description            :text
#  created_at             :datetime
#  updated_at             :datetime
#  soundfile_file_name    :string(255)
#  soundfile_content_type :string(255)
#  soundfile_file_size    :integer
#  soundfile_updated_at   :datetime
#

class Lecture < ActiveRecord::Base
	# TODO change to `ordering` attribute
	default_scope :order => :id

	

	attr_accessible :name, :description, :soundfile, :soundfile_file_name, :soundfile_file_content_type, :soundfile_file_size, :soundfile_updated_at, :questions_attributes
	belongs_to :lesson
	has_many :questions
	has_many :users
	accepts_nested_attributes_for :questions

	has_attached_file :soundfile,
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :path => "/:id/:filename"


    def previous
    	self.class.where("#{self.class.table_name}.id < ?", self.id).last
    end

    def next
    	self.class.where("#{self.class.table_name}.id > ?", self.id).first
    end
end
