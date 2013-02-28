class RemoveClassroomIdFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :classroom_id
  end

  def down
  end
end
