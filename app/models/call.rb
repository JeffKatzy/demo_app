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

  @@account_sid = 'ACc59c478180144c19b6029ec595f0719f'
  @@auth_token = '2273acfc6ba1c74c14e7e43d3eebe971'
        # set up a client to talk to the Twilio REST API
  @@client = Twilio::REST::Client.new(@account_sid, @auth_token)
  @@account = @client.account


  belongs_to :user

  attr_accessible :to, :from, :called, :caller
  attr_accessible :account_sid, :call_sid, :call_status, :digits
  before_validation { self.state = "greeting" unless state.present? }
  call_flow :state, :initial => :initial do

    state :initial do
     event :incoming_call, :to => :greeting
    end

    state :greeting do
      # TODO if user has a current question id, transition to play_question
      # TODO else transition to play_lecture
      event :greeted, :to => :advance_user
      event :no_classroom, :to => :gather_classroom_number
      event :new_user, :to => :play_demo

      response do |x|
        if user.new_user?
          x.Say "Hi new user"
          x.Redirect flow_url(:new_user)
        elsif user.classroom_id == nil
          x.Say "It looks like you are not assigned to a classroom.  Let's take
          care of that now."
          x.Redirect flow_url(:no_classroom)
        else  
          x.Say "Welcome back! Let's get back to your classes.  Remember, you can press the number one to skip a lecture and move on to questions."
          x.Redirect flow_url(:greeted)
        end
      end
    end

    state :play_demo do
      event :played_demo, :to => :evaluate_demo_number

      response do |x|
        x.Gather :numDigits => '1', :action => flow_url(:played_demo) do
            x.Play "https://s3.amazonaws.com/Sample_MP3_File/video.mp3"
        end
      end
    end

    state :evaluate_demo_number do
      event :skip_demo, :to => :advance_user
      event :correct_number, :to => :correct_demo_response

      response do |x|
        if digits == '9'
          x.Redirect flow_url(:skip_demo)
        elsif digits == '1'
          x.Redirect flow_url(:correct_number)
        else
          x.Redirect flow_url(:incorrect_number)
        end
      end
    end

    state :correct_demo_response do
      event :finished_demo, :to => :advance_user

      response do |x|
         x.Gather :numDigits => '1', :action => flow_url(:finished_demo) do
            message = @@account.sms.messages.create({:from => '+12159872011', :to => '+1' + '2154997415', :body => 
           'Hi user.'})
            puts message 
            x.Play "https://s3.amazonaws.com/Sample_MP3_File/video.mp3"
        end
      end
    end

    state :incorrect_demo_response do
      event :finished_demo, :to => :advance_user

      response do |x|
         x.Gather :numDigits => '1', :action => flow_url(:finished_demo) do
            message = @@account.sms.messages.create({:from => '+12159872011', :to => '+1' + '2154997415', :body => 
           'Hi user.'})
            puts message
            x.Play "https://s3.amazonaws.com/Sample_MP3_File/video.mp3"
        end
      end
    end 

    state :gather_classroom_number do
      event :received_number, :to => :evaluate_classroom_number

      response do |x|
        x.Gather :numDigits => '3', :action => flow_url(:received_number) do
          x.Say "Please enter the 3 digit classroom number given by your teacher.
          If you do not know this number, press 999 to move on."
        end
      end
    end

    state :evaluate_classroom_number do
      event :no_number, :to => :advance_user
      event :correct_number, :to => :advance_user
      event :wrong_number, :to => :gather_classroom_number
      response do |x|
        if digits == '999'
          x.Say "Ok, we'll move on."
          x.Redirect flow_url(:no_number)
        elsif user.assign_classroom(digits) == "no classroom"
          x.Say "Looks like you entered the wrong classroom number.
          Let's try it again."
          x.Redirect flow_url(:wrong_number)
        else 
          user.assign_classroom(digits)
          user.save
            x.Say "Great you are now in the 
            classroom #{user.classroom.name} which is 
            taught by #{user.classroom.teacher.name}"
            x.Redirect flow_url(:correct_number)
        end
      end
    end

    state :determine_current_segment do
      event :going_to_lecture,  :to => :play_lecture
      event :going_to_question, :to => :play_question
      
      response do |x|
         # x.Say "Determining current segment."
          if user.on_lecture?
            #x.Say "Going to lecture #{user.lecture.id}"
            x.Redirect flow_url(:going_to_lecture)
          else
            # x.Say "Going to question #{user.question.id}"
            x.Redirect flow_url(:going_to_question)
          end
       end
    end

    state :play_lecture do
      
      event :lecture_finished, :to => :repeat_or_advance

      response do |x|
        x.Gather :numDigits => '1', :action => flow_url(:lecture_finished) do
          x.Play user.lecture.soundfile.url
          user_lecture = user.user_lectures.build(:lecture_id => user.lecture.id)
          user_lecture.save
        end
        #x.Play "http://com.twilio.music.classical.s3.amazonaws.com/Mellotroniac_-_Flight_Of_Young_Hearts_Flute.mp3",
        #HOLD_MUSIC.sort_by { rand }.each do |url|
        #  x.Play url
        #end
      end
    end

    # In this state, we should have access to digits
    state :repeat_or_advance do
      event :request_repeat, :to => :determine_current_segment
      event :request_advance,  :to => :advance_user
      response do |x|
          #x.Say "You pressed #{digits}."
         if digits == "1"
            x.Say "Ok, we'll repeat this for you."
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
            x.Play user.question.soundfile.url
          end
        end
    end

    state :check_if_correct do
      event :answer_correct,   :to => :advance_user
      event :answer_incorrect, :to => :question_explanation
        response do |x|
          x.Say "You pressed #{digits}."
          answer = user.user_answers.build(question_id: user.question.id, value: digits, user_lecture_id: user.user_lectures.last.id)
          answer.assert_correct
          answer.save
            if digits == user.question.answer.to_s #you will need to write a function that checks if its correct or not
              x.Say "Great, that's right.  Now we'll move onto the next question."
              x.Redirect flow_url(:answer_correct) #then send to next question, perhaps by 
              #first writing a state that changes current question to the next question.  Then resend to current question.
            else
              x.Redirect flow_url(:answer_incorrect)
            end
        end
    end

    state :question_explanation do
      event :explanation_end, :to => :advance_user
        response do |x|
          x.Play user.question.explanationfile.url
          x.Redirect flow_url(:explanation_end)
        end
    end

     state :advance_user do
        event :advancing_user, :to => :determine_current_segment
        response do |x|
          user.advance
          user.save #don't know why this is not working
          # x.Say "We have advanced you to the next part."
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
        #user.update_attributes(:lecture_id => user.lecture.id, :question_id => user.question.id)
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
