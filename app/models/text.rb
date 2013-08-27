# == Schema Information
#
# Table name: texts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Text < ActiveRecord::Base

  def self.send_text_to phone, body
    @client = Twilio::REST::Client.new(ENV['TW_SID'], ENV['TW_TOK'])
    @account = @client.account
    @account.sms.messages.create(:from => TWILIO_NUMBER, :to => phone, :body => body)
  end

end
