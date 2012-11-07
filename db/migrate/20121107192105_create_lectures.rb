class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.integer :lesson_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
