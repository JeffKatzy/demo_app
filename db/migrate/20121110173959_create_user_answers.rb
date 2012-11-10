class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.integer :question_id
      t.integer :user_id
      t.integer :explanation_id
      t.integer :value

      t.timestamps
    end
  end
end
