class LessonsController < ApplicationController
  layout 'pages'
  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.create(params[:lesson])
    if @lesson.save
      redirect_to @lesson
    else
      render 'new'
    end
  end

  def index
    @lessons = Lesson.all
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  def edit
  end

  def delete
  end
end
