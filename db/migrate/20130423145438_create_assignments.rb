class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :lecture_id
      t.integer :classroom_id
      t.integer :user_id

      t.timestamps
    end
  end
end
