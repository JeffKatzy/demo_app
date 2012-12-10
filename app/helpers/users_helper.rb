module UsersHelper

	def performance(user)
		if user.user_answers.grade == "mastered"
			"btn btn-success"
		elsif user.user_answers.grade == "passed"
			"btn btn-warning"
		elsif user.user_answers.grade == "failed"
			"btn btn-danger"
		elsif user.user_answers.grade == "no answers"
			"btn"
		end
	end

	def correct?(answer)
		if answer.correct? == true
			"btn btn-success"
		elsif answer.correct? == false
			"btn btn-danger"
		else
			"btn"
		end
	end
end
