class Sms < ActiveRecord::Base
  attr_accessible :content_received, :incoming_number
end
