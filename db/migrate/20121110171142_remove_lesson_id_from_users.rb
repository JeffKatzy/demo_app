class RemoveLessonIdFromUsers < ActiveRecord::Migration
  def up
  	remove_column :users, :lesson_id
  end

  def down
  end
end
