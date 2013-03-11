class ClassroomsController < ApplicationController
layout 'pages'
	def new
		@classroom = Classroom.new
	end

	def create
		@classroom = Classroom.new(params[:classroom])
		if @classroom.save
			@auth.classrooms << @classroom
			redirect_to @auth
		else
			render 'new'
		end
	end

	def show
		@classroom = Classroom.find(params[:id])
		@users = @classroom.users
	end

	def index
		@classroom = Classroom.all
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
		@classroom = @current_teacher.classrooms.build
	end

	def create_teacher_classroom
		@classroom = @current_teacher.classrooms.build(params[:classroom])
		if @classroom.save
			redirect_to @current_teacher
		else
			render 'new'
		end
	end
end
