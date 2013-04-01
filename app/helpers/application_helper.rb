module ApplicationHelper
  def intellinav
    links = ""

    if @auth.present?
      links += wrap(link_to('edit profile', edit_teacher_path(@auth)))

      links += wrap(link_to('Logout ' + @auth.name + ' - ', signout_path, :method => 'delete'))
    elsif @demo.present?
    else
      links += wrap(link_to('Register', new_teacher_path, :remote => true, :id => 'register_btn'))
      links += wrap(link_to('Signin', signin_path, :remote => true, :id => 'login_btn'))
      links += wrap(link_to('Demo', demo_path))
    end
  end

  def is_user?
    @auth.present?
  end

  def classroomnav
    links = ""

    if @auth.present?
      @auth.classrooms.each do |classroom|
        links += wrap(link_to(classroom.name, classroom))
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

  def wrap(link)
    "<li>#{link}</li>"
  end

end
