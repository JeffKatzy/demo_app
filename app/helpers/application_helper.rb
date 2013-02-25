module ApplicationHelper
  def intellinav
    links = ""

    if signed_in?
      "<li>#{link_to('logout' + @current_teacher.name, signin_path, :method => :delete, :confirm => "Are you sure")}"
      # if @auth.is_admin
        # links += "<li>#{link_to("Show Users", users_path)}</li>"
      # end
      links += "<li>#{link_to('edit profile', edit_teacher_path(@current_teacher))}</li>"
      links += "<li>#{link_to('Logout ' + @current_teacher.name + ' - ', signout_path, :method => 'delete')}</li>"
    else
      "<li>#{link_to('Create Account', new_teacher_path)}</li>" +
      "<li>#{link_to('Signin', signin_path)}</li>"
    end
  end

  def is_admin
    @auth.present? && @auth.is_admin
  end

end
