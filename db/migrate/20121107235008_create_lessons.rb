class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :lecture_id
      t.integer :question_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
