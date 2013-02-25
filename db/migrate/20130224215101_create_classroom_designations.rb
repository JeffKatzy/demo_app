class CreateClassroomDesignations < ActiveRecord::Migration
  def change
    create_table :classroom_designations do |t|
      t.integer :classroom_id
      t.integer :user_id

      t.timestamps
    end
  end
end
