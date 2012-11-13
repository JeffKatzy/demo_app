class RemoveQuestionIdFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :question_id
    #remove_column :users, :answer_id
  end

  def down
    add_column :users, :question_id, :integer
  end
end
