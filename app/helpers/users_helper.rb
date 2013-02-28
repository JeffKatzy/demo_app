module UsersHelper

	def performance(user)
		if user.user_answers.grade == "mastered"
			"button radius success"
		elsif user.user_answers.grade == "passed"
			"button radius"
		elsif user.user_answers.grade == "failed"
			"button radius alert"
		elsif user.user_answers.grade == "no answers"
			"panel radius"
		end
	end

	def correct?(answer)
		if answer.correct? == true
			"button radius success"
		elsif answer.correct? == false
			"button radius alert"
		else
			"button radius"
		end
	end
end
