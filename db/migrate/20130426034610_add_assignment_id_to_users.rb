class AddAssignmentIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :assignment_id, :integer
  end
end
