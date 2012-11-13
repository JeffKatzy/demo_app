class RemoveLecQuestFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :lec_quest
  end

  def down
    add_column :users, :lec_quest, :integer
  end
end
