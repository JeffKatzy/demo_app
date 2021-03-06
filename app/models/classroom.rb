# == Schema Information
#
# Table name: classrooms
#
#  id         :integer          not null, primary key
#  teacher_id :integer
#  name       :string(255)
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  random     :string(255)
#

class Classroom < ActiveRecord::Base
	attr_accessible :name, :number, :teacher_id, :classroom_ids
  has_many :classroom_designations
	has_many :users, :through => :classroom_designations
  before_save :generate_random
	belongs_to :teacher
  has_many :assignments

  def classroom_push(answer)
    Pusher["classroom_#{self.id}"].trigger('update_student_answer', {
      user: answer.user.id, question: answer.question.id, correct: answer.correct, total_lecture_questions: answer.user_lecture.user_answers.count })
  end

  def classroom_push_lecture(user_lecture)
    Pusher["classroom_#{self.id}"].trigger('update_student_lecture', {
      user: user_lecture.user.id, user_lecture: user_lecture.lecture.name })
  end

  def generate_random
    self.random = SecureRandom.hex(2)
  end

  def lectures
    assignments.map {|a| a.lecture if a.lecture.present? }.uniq.compact
  end

  def unused_lectures
    Lecture.all - self.lectures
  end
end
