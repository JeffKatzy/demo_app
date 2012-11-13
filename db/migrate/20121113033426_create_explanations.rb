class CreateExplanations < ActiveRecord::Migration
  def change
    create_table :explanations do |t|
      t.string :name
      t.text :description
      t.integer :question_id

      t.timestamps
    end
  end
end
