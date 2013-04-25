module UsersHelper

	# def performance(object)
	# 	if object.user_answers.grade == "mastered"
	# 		"green"
	# 	elsif object.user_answers.grade == "passed"
	# 		"yellow"
	# 	elsif object.user_answers.grade == "failed"
	# 		"red"
	# 	elsif object.user_answers.grade == "no answers"
	# 		"default_color"
	# 	else
	# 		"default_color"
	# 	end
	# end

	def evaluate(percentage)
		if percentage == nil
			"default_color"
		elsif percentage > 70
			"green"
		elsif percentage > 55
			"yellow"
		elsif percentage >= 0
			"red"
		else
			"default_color"
		end
	end

	def correct?(answer)
		if answer.correct? == true
			"green"
		elsif answer.correct? == false
			"yellow"
		else
			"red"
		end
	end
end
