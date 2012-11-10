class AddLectureIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lecture_id, :integer
  end
end
