class UsersController < ApplicationController
  layout 'pages'
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		@user.assign_classroom(@user.classroom_id)
		if @user.save
      if @auth.present?
        redirect_to @auth
      else
			 redirect_to @user
      end
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
		@current_lectures = @user.user_lectures.current
		@todays_lectures = @user.user_lectures.today
    @lectures = @user.user_lectures
	end

	def index
		@classroom = Classroom.find(params[:classroom_id])
		@users = @classroom.users
	end

	def edit
		@user = User.find(params[:id])
    render 'new'
	end

	 def update
    		@user = User.find(params[:id])
    	if @user.update_attributes(params[:user])
      		redirect_to @user
    	else
      		render 'edit'
    	end
  	end
end
