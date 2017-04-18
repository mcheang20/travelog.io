module UsersHelper
  def user_is_authorized?
    current_user == @user
  end
end
