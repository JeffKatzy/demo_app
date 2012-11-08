class AddDigitsToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :digits, :string
  end
end
