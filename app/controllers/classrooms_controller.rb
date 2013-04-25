class ClassroomsController < ApplicationController
layout 'pages'
	def new
		@classroom = Classroom.new
	end

	def create
		@classroom = Classroom.new(params[:classroom])
		if @classroom.save
			@auth.classrooms << @classroom
		else
			render 'new'
		end
	end

	def show
		@classroom = Classroom.find(params[:id])
		@users = @classroom.users
		@answers = UserAnswer.today.where(user_id: @users.map(&:id))
		@user = User.new
	end

	def index
		@classrooms = @auth.classrooms
	end

	def edit
		@classroom = Classroom.find(params[:id])
		render 'new_teacher_classroom'
	end

	def update
		@classroom = Classroom.find(params[:id])
		if @classroom.update_attributes(params[:classroom])
			redirect_to @classroom
		else
			render 'new_teacher_classroom'
		end
	end

	def new_teacher_classroom
		@classroom = @auth.classrooms.build
	end

	def create_teacher_classroom
		@classroom = @auth.classrooms.build(params[:classroom])
		if @classroom.save
			redirect_to @auth
		else
			render 'new'
		end
	end

	def cancel
	end

	def demo
		@demo = true
		@classroom = Classroom.find(15)
		@users = @classroom.users
		@answers = UserAnswer.where(user_id: @users.map(&:id))
		@user = User.new
	end

	def chart
		user = User.find(params[:user_id])
		render :json => user.user_lectures.each_with_index.map {|ul, i| { :a => ul.user_answers.percentage_correct, :y => "#{ul.lecture.name}", label: "#{ul.user.name}" }}
  end

  def assignments
  	@current_classroom = Classroom.find(params[:id])
  	@current_assignments = @current_classroom.assignments.map { |a| a.lecture }
  	@available_assignments = Lecture.all - @current_classroom.assignments
  end

	def getinfo
		@classroom = Classroom.find(params[:classroom])
		@users = @classroom.users
		user_ids = @users.map(&:id)
		if params[:attr] == 'current'
			@answers = UserAnswer.current.where(user_id: user_ids)
		elsif params[:attr] == 'today'
			@answers = UserAnswer.today.where(user_id: user_ids)
		else params[:attr] == 'overall'
			@answers = UserAnswer.where(user_id: user_ids )
		end
	end
end
