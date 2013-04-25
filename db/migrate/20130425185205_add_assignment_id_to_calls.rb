class AddAssignmentIdToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :assignment_id, :integer
  end
end
