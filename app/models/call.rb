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
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  state       :string(255)
#  digits      :string(255)
#  user_id     :integer
#

class Call < ActiveRecord::Base
  include CallCenter

  belongs_to :user
  belongs_to :assignment
  scope :today, lambda { where("created_at > ?", 1.day.ago) }

  attr_accessible :to, :from, :called, :caller
  attr_accessible :account_sid, :call_sid, :call_status, :digits, :assignment_id
  before_validation { self.state = "greeting" unless state.present? }
  call_flow :state, :initial => :initial do

    state :initial do
      Rails.logger.warn("in initial")
     event :incoming_call, :to => :greeting
    end

    state :greeting do
      # TODO if user has a current question id, transition to play_question
      # TODO else transition to play_lecture
      Rails.logger.warn("in greeting")
      event :classroom, :to => :gather_classroom_number
      event :new_user, :to => :play_demo

      response do |x|
        if user.classrooms == []
          Rails.logger.warn("in new user")
           x.Say "Hi new user.  Please hang up and text class plus your classroom number to sign up for a classroom"
          x.Redirect flow_url(:hang_up)
        else
          x.Say "Welcome back #{user.name}!"
          x.Redirect flow_url(:classroom)
        end
      end
    end



    state :gather_classroom_number do
      event :received_number, :to => :evaluate_classroom_number

      response do |x|
        x.Gather :numDigits => '1', :action => flow_url(:received_number) do
          x.Say "Go ahead and choose your lessons."
          @classrooms = self.user.classrooms.uniq
          @classrooms.each_with_index do |c, i|
            x.Say "Press #{i.to_i + 1} to hear lessons from your #{c.name} class."
          end
        end
      end
    end

    state :evaluate_classroom_number do
      event :correct_number, :to => :adding_user
      event :wrong_number, :to => :gather_classroom_number
      event :play_lecture, :to => :play_lecture
      event :advance_user, :to => :advance_user
      response do |x|
        @classrooms = self.user.classrooms.uniq
        @classroom = @classrooms[digits.to_i - 1]
        if @classroom.present?
          x.Say "Great.  You would like assignments from your #{@classroom.name} class."
          a = user.assignments.incomplete.select{ |a|  a.classroom_id == @classroom.id  }.first
          user.assignment_id = a.id
          if a.user_lecture.nil?
            user.lecture = a.lecture
            user.save
            x.Redirect flow_url(:play_lecture)
          else
            user.lecture = a.lecture
            i = a.user_lecture.user_answers.count.to_i
            user.question = a.user_lecture.user_answers[i]
            user.save
            x.Redirect flow_url(:advance_user)
          end
          x.Redirect flow_url(:correct_number)
        else
          x.Say "Looks like you entered the wrong classroom number.
          Let's try it again."
          x.Redirect flow_url(:wrong_number)
        end
      end
    end

    state :adding_user do
      event :advance_user, :to => :advance_user
      #Need this so that event is marked as adding the user
      response do |x|
        x.Redirect flow_url(:advance_user)
      end
    end

    state :determine_current_segment do
      event :going_to_lecture,  :to => :play_lecture
      event :going_to_question, :to => :play_question

      response do |x|
         # x.Say "Determining current segment."
          if user.on_lecture?
            #x.Say "Going to lecture #{user.lecture.id}"
            #to rewrite on lecture as, if assignment.user_lectures.empty? (we only have one lecture per assignment.)
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
          user_lecture = user.user_lectures.build(:lecture_id => user.lecture.id, :assignment_id => user.assignment_id)
          user_lecture.save
          x.Play user.lecture.soundfile.url
          user_lecture.end_time = Time.now
        end
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
          classroom = user.classrooms.first #assign random classroom
          classroom.classroom_push(answer)
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
