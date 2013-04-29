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

require 'spec_helper'

describe Assignment do
  pending "add some examples to (or delete) #{__FILE__}"
end
