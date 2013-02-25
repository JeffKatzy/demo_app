class ClassroomDesignation < ActiveRecord::Base
  attr_accessible :classroom_id, :user_ids
  belongs_to :user
  belongs_to :classroom
end
