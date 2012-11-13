class AddLectureQuestionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lec_quest, :integer
  end
end
