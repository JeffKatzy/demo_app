class AddRandomToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :random, :string
  end
end
