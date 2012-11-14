class RemoveExplanationIdFromUserAnswers < ActiveRecord::Migration
  def up
    remove_column :user_answers, :explanation_id
  end

  def down
    add_column :user_answers, :explanation_id, :integer
  end
end
