class SessionsController < ApplicationController
	layout 'pages'
	def new
	end

	def create
		@teacher = Teacher.find_by_email(params[:session][:email].downcase)
		if @teacher && @teacher.authenticate(params[:session][:password])
			sign_in @teacher
			redirect_to @teacher
			flash[:success] = "Welcome to the Sample App!"
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
