# == Schema Information
#
# Table name: assignments
#
#  id           :integer          not null, primary key
#  lecture_id   :integer
#  classroom_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  completed    :boolean
#

class Assignment < ActiveRecord::Base
  attr_accessible :classroom_id, :lecture_id, :user_id, :completed
  has_one :call
  belongs_to :lecture
  belongs_to :classroom
  belongs_to :user
  has_one :user_lecture
  scope :complete, where(:completed => true)
  scope :incomplete, where(:completed => nil)

  def completed?
    if user_lectures.first && user_lectures.first.(:try).completed?
      true
    else
      false
    end
  end
end
