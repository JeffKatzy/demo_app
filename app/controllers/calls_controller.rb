class CallsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :parse_params
  before_filter :find_and_update_call, :only => [:flow, :destroy]

  def create
    @call = Call.create!(@parsed_params)
    render :xml => @call.run(:incoming_call)
  end

  def flow
    render :xml => @call.run(params[:event])
  end
end