class LecturesController < ApplicationController
	def new
		@lecture = Lecture.new
	end

	def create
		@lecture = Lecture.create(params[:lecture])
		@lecture.save
		redirect_to @lecture
	end

	def show
		@lecture = Lecture.find(params[:id])
	end

	def play
		@lecture = Lecture.find(params[:id])
		@audio_lesson_url = @lecture.sound_file.url
	end

	def edit
	end

	def delete
	end

	def index
		@lectures = Lecture.all
	end
end
