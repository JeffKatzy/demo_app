class UsersController < ApplicationController
	def new 
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		@user.assign_classroom(@user.classroom_id)
		if @user.save
			redirect_to @user
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
		@lectures = @user.user_lectures.find(:all, :order => 'created_at DESC')
		@lecture_days = @lectures.group_by { |t| t.created_at.beginning_of_day }
	end

	def index
		@classroom = Classroom.find(params[:classroom_id]) 
		@users = @classroom.users
	end

	def today
		@users = User.all
	end
end
