class AddLectureIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :lecture_id, :integer
  end
end
