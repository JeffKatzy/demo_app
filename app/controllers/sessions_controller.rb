class SessionsController < ApplicationController

	def new
	end

	def create
		teacher = Teacher.find_by_email(params[:session][:email].downcase)
		if teacher && teacher.authenticate(params[:session][:password])
			#sign in teacher and redirect to teacher's show page
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
