# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  email       :string(255)
#  cell_number :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  lecture_id  :integer
#  question_id :integer
#

class User < ActiveRecord::Base
	attr_accessible :name, :email, :cell_number
  belongs_to :lecture
  belongs_to :question
	after_create :initialize_lecture
  has_many :user_answers
  attr_accessor :lec_quest
  
	
	has_many :calls

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

 def advance_lecture_and_set_questions
    if self.lecture.nil?
      self.lecture = Lecture.first
      self.question = nil
    else
      self.lecture = lecture.next
      self.question = nil
    end
 end

 def advance_questions
    if self.question.nil?
      self.question = self.lecture.questions.first
    else
      self.question = question.next_in_lecture
    end
 end 

  def advance
    if lecture.nil? || lecture.questions.first.nil? || question == lecture.questions.last #if user unassigned lecture, lecture has no questions, or on the last question
      advance_lecture_and_set_questions
    else
      advance_questions
    end
  end
end
