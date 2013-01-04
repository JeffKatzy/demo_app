module UsersHelper

	def performance(user)
		if user.user_answers.grade == "mastered"
			"btn btn-success span11"
		elsif user.user_answers.grade == "passed"
			"btn btn-warning span11"
		elsif user.user_answers.grade == "failed"
			"btn btn-danger span11"
		elsif user.user_answers.grade == "no answers"
			"btn span11"
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
