class TeachersController < ApplicationController
	layout 'pages'
	def new
		@teacher = Teacher.new
	end

	def create
		@teacher = Teacher.new(params[:teacher])
		if @teacher.save
			session[:teacher_id] = @teacher.id
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @teacher
		else
			render 'new'
		end
	end

	def edit
		@teacher = Teacher.find(params[:id])
		render 'new'
	end

	def update
		@teacher = Teacher.find(params[:id])
		if @teacher.update_attributes(params[:classroom])
			redirect_to @teacher
		else
			render 'new'
		end
	end

	def show
		@teacher = Teacher.find(params[:id])
	end

	def index
		@teachers = Teacher.all
	end
end
