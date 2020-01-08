module RolesHelper
  def current_user_role
    if logged_in?
      return current_user.role
    else
      return 'anonymous'
    end
  end

  def can_edit?(tip)
    case current_user.role
    when 'registered' then current_user == tip.user if tip.class == Tip
    when 'admin' then true
    else false
    end
  end
end