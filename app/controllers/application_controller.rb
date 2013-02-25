class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_teacher
  include SessionsHelper

  def current_teacher
    @current_teacher ||= Teacher.find_by_remember_token(cookies[:remember_token])
  end

  def authentication
    @auth = Teacher.find(session[:teacher_id]) if session[:teacher_id].present?
  end

  def check_if_admin
    redirect_to(root_path) if @auth.nil? || !@auth.is_admin
  end
end
