class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authentication

  def authentication
    @auth = Teacher.find(session[:teacher_id]) if session[:teacher_id].present?
  end

  def reset_demo
    @demo = false
  end

  # If you are using the localtunnel gem to test, you can uncomment this block and replace the host url with the one it prints on startup.
  # This makes the urls set up with the given host/port instead of localhost:3000.
  # E.g.
  #     $ localtunnel 3000
  #     Port 3000 is now publicly accessible from http://3yde.localtunnel.com ...
  # def default_url_options
    # if Rails.env.development?
      # {:host => "3yde.localtunnel.com", :port => 80}
    # else  
      # {}
    # end
  # end
end
