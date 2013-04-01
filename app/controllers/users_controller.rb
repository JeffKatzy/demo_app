class UsersController < ApplicationController
  layout 'pages'

  def new
		@user = User.new
	end

	def create
    @user = User.create(name: params[:user][:name], email: params[:user][:email], cell_number: params[:user][:cell_number])
    @classroom = Classroom.find(params[:user][:classroom_id].to_i)
    @user.classrooms << @classroom
    @user.save
    @users = @classroom.users
    @answers = UserAnswer.today.where(user_id: @users.map(&:id))
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

  def cancel
  end

end
