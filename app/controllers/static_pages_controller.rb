class StaticPagesController < ApplicationController
  layout 'application'
  def home
    @teacher = Teacher.new
  end

  def help
  end
end
