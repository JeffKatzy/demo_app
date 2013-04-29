# == Schema Information
#
# Table name: classrooms
#
#  id         :integer          not null, primary key
#  teacher_id :integer
#  name       :string(255)
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  random     :string(255)
#

require 'spec_helper'

describe Classroom do
  pending "add some examples to (or delete) #{__FILE__}"
end
