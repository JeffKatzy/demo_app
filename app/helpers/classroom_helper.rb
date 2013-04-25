module ClassroomHelper
	def name_number(user)
		if user.name?
			link_to user.name, '#'
		else
			link_to "Set Name", edit_user_path(user), :class => 'set_name'
		end
	end
end
