require 'twilio-ruby'

class SimpleCall

  # Initiate a phone call.
  def self.initiate_call_to! phone, url
    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new(ENV['TW_SID'], ENV['TW_TOK'])
    Rails.logger.info("Going to call #{phone} from #{TWILIO_NUMBER} with callback url #{url}")
    # make a new outgoing call
    @call = @client.account.calls.create(
      :from => TWILIO_NUMBER,
      :to => phone,
      :url => url
    )
  end

end
