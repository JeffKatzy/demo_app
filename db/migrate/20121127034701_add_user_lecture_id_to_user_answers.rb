class AddUserLectureIdToUserAnswers < ActiveRecord::Migration
  def change
    add_column :user_answers, :user_lecture_id, :integer
  end
end
