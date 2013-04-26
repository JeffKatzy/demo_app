class SmsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @sms = Sms.create(:incoming_number => params['From'], :content_received => params['Body'].downcase)
    user = User.where(cell_number: params['From']).first
    user = User.create(cell_number: params['From']) if user.nil?
    if @sms.content_received.match(/class/)
      random = @sms.content_received.downcase.split(/class/).delete_if(&:empty?).last.strip
      user.add_user_to_classroom(random, user)
      render :nothing => true
    elsif user.name == nil
      user.register(@sms.content_received)
      render :nothing => true
    elsif @sms.content_received.match(/projects/)
      user.text_assignments
      session[:state] = "choosing hw"
      render :nothing => true
    else
      message = "You did not enter a valid text.  Please type 'projects' to see your current assignments, or 'class' followed by the classroom number to enter a classroom."
      Text.send_text_to(user.cell_number, message)
      session[:state] = nil
      render :nothing => true
    end

  end
end