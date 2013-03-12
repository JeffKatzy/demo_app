class SessionsController < ApplicationController
	layout 'pages'
	def new
	end

	def create
		@teacher = Teacher.where(:email => params[:session][:email]).first
		if @teacher.present? && @teacher.authenticate(params[:session][:password])
			session[:teacher_id] = @teacher.id
			redirect_to(root_path)
			flash[:success] = "Welcome to the Sample App!"
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		session[:teacher_id] = nil
		redirect_to root_path
	end
end
