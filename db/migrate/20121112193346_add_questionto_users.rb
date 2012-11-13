class AddQuestiontoUsers < ActiveRecord::Migration
  def up
  	add_column :users, :question_id, :integer
  end

  def down
  end
end
