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
#  digits      :string(255)
#  user_id     :integer
#

class Call < ActiveRecord::Base
  include CallCenter

  belongs_to :user

  attr_accessible :to, :from, :called, :caller
  attr_accessible :account_sid, :call_sid, :call_status, :digits

  call_flow :state, :initial => :initial do

    state :initial do
     event :incoming_call, :to => :greeting
    end

    state :greeting do
      # TODO if user has a current question id, transition to play_question
      # TODO else transition to play_lecture
      event :greeted, :to => :determine_current_segment

      response do |x| 
        x.Say "Welcome back! Let's get back to your classes."
        #x.Play "http://com.twilio.music.classical.s3.amazonaws.com/MARKOVICHAMP-Borghestral.mp3"
        x.Redirect flow_url(:greeted)
      end
    end

    state :determine_current_segment do
      event :going_to_lecture,  :to => :play_lecture
      event :going_to_question, :to => :play_question
      
        response do |x|
          x.Say "Determining current segment."
          if user.on_lecture?
            x.Say "Going to lecture #{user.lecture.id}"
            x.Redirect flow_url(:going_to_lecture)
          else
            x.Say "Going to question #{user.question.id}"
            x.Redirect flow_url(:going_to_question)
          end
       end
    end

    state :play_lecture do
      
      event :lecture_finished, :to => :repeat_or_advance

      response do |x|
        x.Gather :numDigits => '1', :action => flow_url(:lecture_finished) do
          x.Say "This is lecture #{user.lecture.id}.  Ok, the lecture is now finished.  Press 1 to repeat, 
          or 2 to move on to questions"
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
    state :repeat_or_advance do
      event :request_repeat, :to => :determine_current_segment
      event :request_advance,  :to => :advance_user
      response do |x|
          x.Say "You pressed #{digits}. Goodbye."
         if digits == 1
            x.Redirect flow_url(:request_repeat)
         else
            x.Redirect flow_url(:request_advance)
         end
      end
    end

    state :play_question do
      event :submit_answer, :to => :check_if_correct
        response do |x|
          x.Gather :numDigits => '1', :action => flow_url(:submit_answer) do
            x.Say "Now let's play question #{user.question.id}."
          end
        end
    end

    state :check_if_correct do
      event :answer_correct,   :to => :advance_user
      event :answer_incorrect, :to => :question_explanation
        response do |x|
          x.Say "You pressed #{digits}."
            if digits == 1 #you will need to write a function that checks if its correct or not
              x.Say "Great, that's right.  Now we'll move onto the next question."
              x.Redirect flow_url(:answer_correct) #then send to next question, perhaps by 
              #first writing a state that changes current question to the next question.  Then resend to current question.
            else
              x.Say "You may need a little help. Let's send you to the explanation"
              x.Redirect flow_url(:answer_incorrect)
            end
        end
    end

    state :question_explanation do
      event :explanation_end, :to => :advance_user
        response do |x|
          x.Say "This is the explanation."
          x.Redirect flow_url(:explanation_end)
        end
    end

     state :advance_user do
        event :advancing_user, :to => :determine_current_segment
        response do |x|
          user.advance
          user.save
          x.Say "We have advanced you to the next part."
          x.Redirect flow_url(:advancing_user)  
        end
     end



    #write logic for 
      #if question is correct, and 
        # if there is another question, 
            # go to the next question
        # if there is not another question
          # go to congrats, 
            #and do you want to go to another lecture
      # if question is incorrect, play explanation
        # then play next question
      # end



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
