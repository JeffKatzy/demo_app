class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.string :incoming_number
      t.string :content_received

      t.timestamps
    end
  end
end
