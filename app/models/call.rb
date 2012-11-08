# == Schema Information
#
# Table name: calls
#
#  id          :integer          not null, primary key
#  to          :string(255)
#  from        :string(255)
#  called      :string(255)
#  account_sid :string(255)
#  call_sid    :string(255)
#  call_status :string(255)
#  caller      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  state       :string(255)
#

class Call < ActiveRecord::Base
  include CallCenter

  attr_accessible :to, :from, :called, :caller
  attr_accessible :account_sid, :call_sid, :call_status, :digits

  call_flow :state, :initial => :initial do
    state :initial do
     event :incoming_call, :to => :greeting
    end

    state :greeting do
      # TODO if user has a current question id, transition to play_question
      # TODO else transition to play_lecture
      event :greeted, :to => :play_lecture

      response do |x| 
        x.Say "Whatever"
        #x.Play "http://com.twilio.music.classical.s3.amazonaws.com/MARKOVICHAMP-Borghestral.mp3"
        x.Redirect flow_url(:greeted)
      end
    end

    state :play_lecture do
      event :repeat, :to => :play_lecture
      event :ready_for_question, :to => :asking_question
      event :lecture_finished, :to => :repeat_lecture_or_give_questions

      response do |x|
        x.Gather :numDigits => '1', :action => flow_url(:lecture_finished) do
          x.Say "this is a lecture. 1 to repeat, 2 to move on to questions"
          x.Hangup
        end
        #x.Play "http://com.twilio.music.classical.s3.amazonaws.com/Mellotroniac_-_Flight_Of_Young_Hearts_Flute.mp3",
        #HOLD_MUSIC.sort_by { rand }.each do |url|
        #  x.Play url
        #end
        
      end

      before(:always) do
        # TODO make sure the user's current question id is cleared, and his current lecture id is updated
      end
    end

    # In this state, we should have access to digits
    state :repeat_lecture_or_give_questions do
      response do |x|
        x.Say "You pressed #{digits}. Goodbye."
        x.Hangup
      end
    end


    state :ended do
      after(:success) do
        update_attributes(:ended_at => Time.now)
      end
    end


    state any do
      event :hang_up, :to => :ended
    end
  end

  # ===============
  # = Call Center =
  # ===============

  def run(event)
    send(event)
    render
  end

  def flow_url(event)
    params = {
      :call_id => self.id,
      :event => event.to_s
    }

    uri = URI.join(ENV['TWILIO_TUNNEL_URL'], "calls/flow")
    uri.query = params.to_query
    uri.to_s
  end

  def redirect_to(event, *args)
    account.calls.get(self.call_sid).update({:url => flow_url(event)})
  end

  def wait_time
    Time.now - (self.waiting_at || self.created_at)
  end

  # ========
  # = REST =
  # ========

  def account
    client.account
  end

  def client
    self.class.client
  end

  def self.client
    @client ||= Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  end

  # ===========
  # = Routing =
  # ===========

  MAX_WAIT_TIME = 60
  HOLD_MUSIC = [
    "http://com.twilio.music.classical.s3.amazonaws.com/ith_chopin-15-2.mp3",
    "http://com.twilio.music.classical.s3.amazonaws.com/oldDog_-_endless_goodbye_%28instr.%29.mp3",
    "http://com.twilio.music.classical.s3.amazonaws.com/ClockworkWaltz.mp3",
    "http://com.twilio.music.classical.s3.amazonaws.com/BusyStrings.mp3",
    "http://com.twilio.music.classical.s3.amazonaws.com/ith_brahms-116-4.mp3"
  ].freeze

  serialize :conference_history, Array

  def can_connect?(call)
    !conference_history.include?(call.from)
  end

  def call_conference_name(call)
    [self.call_sid, call.call_sid].sort.join('::')
  end

  def connect(call)
    self.conference_name = call_conference_name(call)
    Rails.logger.info "Creating conference: #{self.conference_name}"
    self.conference_history << call.from
    self.save!
    self.redirect_and_put_in_conference!
  end

  def location
    if caller_states = Carmen::states(self.caller_country)
      title_and_abbreviation = caller_states.detect { |title, abbr| abbr == self.caller_state }
      if title_and_abbreviation
        return "Someone in #{self.caller_city.capitalize}, #{title_and_abbreviation.first}"
      end
    end
    "Someone in #{self.caller_city.capitalize}, #{self.caller_state}"
  rescue Carmen::StatesNotSupported, Carmen::NonexistentCountry
    "An Unknown Caller"
  end

  def as_json(options = {})
    {
      :location => location,
      :conference_name => conference_name
    }
  end

end
