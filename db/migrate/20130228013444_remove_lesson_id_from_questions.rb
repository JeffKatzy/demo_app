class RemoveLessonIdFromQuestions < ActiveRecord::Migration
  def up
    remove_column :questions, :lesson_id
  end

  def down
  end
end
