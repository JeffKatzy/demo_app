class Assignment < ActiveRecord::Base
  attr_accessible :classroom_id, :lecture_id, :user_id

  belongs_to :lecture
  belongs_to :classroom
  belongs_to :user
end
