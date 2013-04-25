class Text < ActiveRecord::Base

  def self.send_text_to phone, body
    @client = Twilio::REST::Client.new(ENV['TW_SID'], ENV['TW_TOK'])
    @account = @client.account
    @account.sms.messages.create(:from => '+12159702907', :to => phone, :body => body)
  end

end
