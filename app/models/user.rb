# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  email       :string(255)
#  cell_number :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lecture_id  :integer
#  question_id :integer
#

class User < ActiveRecord::Base
	attr_accessible :name, :email, :cell_number, :lecture_id, :classroom_ids, :assignment_id
  scope :incomplete, where("name IS NULL OR email IS NULL")

  belongs_to :lecture
  belongs_to :question
	after_create :initialize_lecture
  has_many :user_answers
  has_many :user_lectures
  has_many :classroom_designations
  has_many :classrooms, :through => :classroom_designations
  has_many :assignments

  scope :top_users, select("users.id, count(user_answers.correct) AS user_answers_correct_count").joins(:user_answers).order("user_answers_correct_count DESC")

	has_many :calls

  def register(content_received)
      user = User.find(self.id)
    if content_received.downcase.match(/name/).nil?
        message = "Looks like you are not registered.  Please text the word 'name' followed by your name to register."
        Text.send_text_to(user.cell_number, message)
    elsif content_received.downcase.match(/name/)
      user.name = content_received.downcase.split(/name/).delete_if(&:empty?).join(" ").strip
      user.save
      message = "Thanks #{user.name}, you are now registered."
      Text.send_text_to(user.cell_number, message)
    end
  end

  def text_assignments
    user = User.find(self.id)
    assignments = user.assignments.incomplete.order(:created_at).limit(5)
    if assignments.incomplete.present?
      message = ""
      assignments.each_with_index do |assignment, index|
        message += "#{index + 1}. #{assignment.lecture.name}" + "\n"
      end
      Text.send_text_to(user.cell_number, message)
    else
      message = "You have no more assignments!"
      Text.send_text_to(user.cell_number, message)
    end
  end

  def add_user_to_classroom(random, user)
    classroom = Classroom.find_by_random(random)
    if user.classrooms.exclude?(classroom)
      user.classrooms << classroom
      classroom.lectures.each do |lecture|
        Assignment.create(classroom_id: classroom.id, user_id: user.id, lecture_id: lecture.id)
      end
      body = "You are now registered for #{classroom.name} class."
      Text.send_text_to(user.cell_number, body)
    end
  end

  def lecture_percentage_correct
      user_answers = user_lectures.map(&:user_answers)
    if (user_answers.try(:flatten).try(:count) != 0) && (user_answers.try(:flatten).try(:count) != nil)
      user_answers.flatten.map(&:correct).count(true) * 100 / user_answers.try(:flatten).count
    else
      0
    end
  end

  def current_percentage_correct
    user_answers_current
    if (user_answers.try(:flatten).try(:count) != 0) && (user_answers.try(:flatten).try(:count) != nil)
      user_answers.try(:flatten).map(&:correct).count(true) * 100 / user_answers.try(:flatten).count
    else
      0
    end
  end

  def lecture_percentage_correct_today
    user_answers_today
    if (user_answers.try(:flatten).try(:count) != 0) && (user_answers.try(:flatten).try(:count) != nil)
      user_answers.flatten.map(&:correct).count(true) * 100 / user_answers.try(:flatten).count
    else
      0
    end
  end

  def user_answers_today
    user_answers = user_lectures.today.map(&:user_answers)
  end

  def user_answers_current
    user_answers = user_lectures.current.last.try(:user_answers)
  end

  def user_answers_current_count
    answers = user_answers_current.try(:count)
    if answers.nil? || user_answers_current.try(:empty?)
      0
    end
  end

  def user_answers_today_count
    answers = user_answers_today.try(:count)
    if answers.nil? || user_answers_today.try(:empty?)
      0
    end
  end

  def assign_classroom(classroom)
    if Classroom.find_by_number(classroom) == nil
      "no classroom"
    else
      classroom = Classroom.find_by_number(classroom)
      classrooms << classroom
    end
    classroom
  end

  def current_lecture #create a filter for today's calls, so that it reads, if today's calls are nil
    if self.calls.last == nil
      "no audio listened to today"
    else
      if self.lecture_id == nil
        "not started"
      else
        Lecture.find(self.lecture_id).name
      end
    end
  end

	def initialize_lecture
    self.lecture_id ||=
      if Lecture.first
          Lecture.first.id
      else
        nil
      end
  end

  def on_lecture?
    question == nil
  end

  def new_user?
    lecture_id == nil && classrooms == []
  end

 def advance_lecture_and_set_questions
    if self.lecture.nil?
      self.lecture = Lecture.first
      self.question = nil
      #puts "1"
    else
      if self.lecture.next == nil
        initialize_lecture
       # puts "2"
      else
        self.lecture = lecture.next
        #puts "3"
      end
      self.question = nil
     # puts "4"
    end
 end

 def advance_questions
    if self.question.nil?
      self.question = self.lecture.questions.first
     # puts "5"
    else
      self.question = question.next_in_lecture
     # puts "6"
    end
 end

  def advance
    #binding.pry
    if lecture.nil? || lecture.questions.first.nil? || question == lecture.questions.last #if user unassigned lecture, lecture has no questions, or on the last question
      advance_lecture_and_set_questions
     # puts "7"
    else
      advance_questions
     # puts "8"
    end
  end
end
