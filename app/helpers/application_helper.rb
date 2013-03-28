module ApplicationHelper
  def intellinav
    links = ""

    if @auth.present?
      "<li>#{link_to('logout' + @auth.name, signin_path, :method => :delete) }</li>"
      # if @auth.is_admin
        # links += "<li>#{link_to("Show Users", users_path)}</li>"
      # end
      links += "<li>#{link_to('edit profile', edit_teacher_path(@auth))}</li>"
      links += "<li>#{link_to('Logout ' + @auth.name + ' - ', signout_path, :method => 'delete')}</li>"
    else
      "<li>#{link_to('Register', new_teacher_path, :id => 'register_btn')}</li>" +
      "<li>#{link_to('Signin', signin_path, :remote => true, :id => 'login_btn')}</li>" +
      "<li>#{link_to('Demo', '/classrooms/5')}</li>"
    end
  end

  def is_user?
    @auth.present?
  end

  def classroomnav
    links = ""

    if @auth.present?
      @auth.classrooms.each do |classroom|
        links += "<li>#{link_to(classroom.name, classroom)}</li>"
      end
    end
     links
  end

  def signed_in?
    @current_teacher.present?
  end

  def is_admin
    @auth.present? && @auth.is_admin
  end

end
