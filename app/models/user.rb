# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  email         :string(255)
#  cell_number   :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  lecture_id    :integer
#  question_id   :integer
#  assignment_id :integer
#

class User < ActiveRecord::Base
	attr_accessible :name, :email, :cell_number, :lecture_id, :classroom_ids, :assignment_id
  scope :incomplete, where("name IS NULL OR email IS NULL")

  belongs_to :lecture
  belongs_to :question
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

  def current_lecture
    lecture.name ||= "Not started"
  end

  def on_lecture?
    question == nil
  end

 def advance_lecture_and_set_questions
    self.question = nil
    # if self.lecture.next == nil
    #   self.lecture
    # else
      self.lecture = lecture.next
    # end
 end

 def advance_questions
  if self.question.nil?
    self.question = self.lecture.questions.first
  else
    self.question = question.next_in_lecture
  end
 end

  def advance
    if question == lecture.questions.last
      advance_lecture_and_set_questions
    else
      advance_questions
    end
  end
end
