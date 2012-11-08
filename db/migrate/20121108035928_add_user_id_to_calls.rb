class AddUserIdToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :user_id, :int
  end
end
