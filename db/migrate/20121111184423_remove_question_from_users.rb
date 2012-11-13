class RemoveQuestionFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :question_id
  end

  def down
    add_column :users, :question_id, :integer
  end
end
