class AddUserIdToUserLectures < ActiveRecord::Migration
  def change
    add_column :user_lectures, :user_id, :integer
  end
end
