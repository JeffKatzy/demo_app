class CreateUserLectures < ActiveRecord::Migration
  def change
    create_table :user_lectures do |t|
      t.integer :lecture_id

      t.timestamps
    end
  end
end
