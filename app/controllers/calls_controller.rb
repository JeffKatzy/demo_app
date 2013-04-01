class CallsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :parse_params
  before_filter :find_and_update_call, :only => [:flow, :destroy]
  before_filter :update_classroom_view

  def create
    @call = Call.create!(@parsed_params)
    @call.user = User.find_or_create_by_cell_number(@parsed_params["from"])
    @call.save
    Rails.logger.warn("Creating call with these parsed params: #{@parsed_params}")
    Rails.logger.warn("Created call: #{@call}")
    Rails.logger.warn("Added user to call #{@call.id}")
    render :xml => @call.run(:incoming_call)
  end

  def flow
    render :xml => @call.run(params[:event])
  end

  def update_classroom_view
    find_call
    @user = @call.user
  end

  private

  def parse_params
    pms = underscore_params
    Rails.logger.warn("underscore_params: #{pms}")
    Rails.logger.warn("Call.column_names: #{Call.column_names}")
    @parsed_params = Call.column_names.inject({}) do |result, key|
      value = pms[key]
      result[key] = value unless value.blank?
      result
    end
    Rails.logger.warn("parsed_params: #{@parsed_params}")
  end

  def underscore_params
    params.inject({}) do |result, k_v|
      k, v = k_v
      result[k.underscore] = v
      result
    end
  end

  def find_call
    @call = (Call.find_by_id(params["call_id"]) || Call.find_by_call_sid(params['CallSid']))
  end

  def find_and_update_call
    find_call
    Rails.logger.warn("in find_and_update_call, about to update #{@call.to_s} with these parsed params: #{@parsed_params}")
    @call.update_attributes(@parsed_params)
  end
end