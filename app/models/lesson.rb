# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Lesson < ActiveRecord::Base
	attr_accessible :name, :description, :lecture_id, :question_id, :lectures_attributes

	has_many :lectures, :dependent => :destroy
  accepts_nested_attributes_for :lectures, :reject_if => lambda { |a| a[:content].blank? }
  validates :name, presence: true
  validates :description, presence: true
  # validate :check_lectures

  def check_lectures
    if self.lectures.size < 1
      errors[:base] << "A lesson must have at least one lecture."
    end
  end

end
