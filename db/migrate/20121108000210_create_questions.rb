class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :lesson_id
      t.string :name
      t.text :description
      t.integer :answer

      t.timestamps
    end
  end
end
