class ApplicationController < ActionController::Base
  protect_from_forgery
   before_filter :authentication

  def authentication
    @auth = Teacher.find(session[:teacher_id]) if session[:teacher_id].present?
  end

  def reset_demo
    @demo = false
  end
end