class AddEndTimeToUserLectures < ActiveRecord::Migration
  def change
    add_column :user_lectures, :end_time, :datetime
  end
end
