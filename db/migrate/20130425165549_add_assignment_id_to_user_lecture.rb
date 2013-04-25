class AddAssignmentIdToUserLecture < ActiveRecord::Migration
  def change
    add_column :user_lectures, :assignment_id, :integer
  end
end
