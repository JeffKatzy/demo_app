class AddLessonToLectures < ActiveRecord::Migration
  def change
  	remove_column :lessons, :lecture_id
  	remove_column :lessons, :question_id
  end
end
