class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authentication
  include SessionsHelper

  def authentication
    @auth = Teacher.find(session[:teacher_id]) if session[:teacher_id].present?
  end
end