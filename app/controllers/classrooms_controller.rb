class ClassroomsController < ApplicationController

	def new
		@classroom = Classroom.new
	end

	def create
		@classroom = Classroom.new(params[:classroom])
		if @classroom.save
			redirect_to @classrooms
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
end
