# == Schema Information
#
# Table name: classroom_designations
#
#  id           :integer          not null, primary key
#  classroom_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ClassroomDesignation < ActiveRecord::Base
  attr_accessible :classroom_id, :user_ids
  belongs_to :user
  belongs_to :classroom
end
