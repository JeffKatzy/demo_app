class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
    	t.string :to
    	t.string :from
    	t.string :called
    	t.string :account_sid
    	t.string :call_sid
    	t.string :call_status
    	t.string :caller
      t.timestamps
    end
  end
end
