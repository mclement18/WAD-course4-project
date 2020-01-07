module RolesHelper
  def current_user_role
    if logged_in?
      return current_user.role
    else
      return 'anonymous'
    end
  end
end