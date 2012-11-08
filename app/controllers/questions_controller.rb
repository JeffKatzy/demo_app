class QuestionsController < ApplicationController
	def new
		@question = Question.new
	end

	def create
		@question = Question.create(params[:question])
		@question.save
		redirect_to @question
	end

	def show
		@question = Question.find(params[:id])
	end

	def play
		@question = Question.find(params[:id])
		@audio_lesson_url = @question.sound_file.url
	end

	def edit
	end

	def delete
	end

	def show
		@questions = Question.all
	end
end
