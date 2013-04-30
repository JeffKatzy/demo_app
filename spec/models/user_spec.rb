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

# Table name: user_answers
#
#  id              :integer          not null, primary key
#  question_id     :integer
#  user_id         :integer
#  value           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  correct         :boolean
#  user_lecture_id :integer


require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  before do
    user.question = user.lecture.questions.first
    user.user_answers.build(question_id: user.question.id, value: 1, correct: true )
  end

  subject { user }

  it { should respond_to(:lecture) }

	it "has a valid factory" do
		FactoryGirl.create(:user).should be_valid
	end

  it "has the correct lecture assigned" do
    user.lecture.name.should eq 'Perimeter Demo'
  end

  it "has the correct question assigned" do
    user.question.answer.should eq 1
  end

  describe ".advance" do
    it "moves to the next question when not at end of lectures questions" do
      user.advance
      user.question.answer.should eq 2
    end

    #TO IMPLEMENT
    # it "moves to the next lecture when at end of lectures questions" do
    #   user.question = user.lecture.questions.last
    # end

    # it "sets the question to the first question of the set of lectures" do
    #   #You will need to write the code for this in the lecture model
        #Also currently assignments only allows for one lecture, so you need to change this.
    # end
  end


    # it "has many user_answers" do
    # end

    # it "has many user_lectures" do
    # end

    # it "has many classroom designations" do
    # end

    # it "has many classrooms" do
    # end

    # it "has many assignments" do
    # end
end
