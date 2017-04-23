module PicsHelper
  def user_is_authorized_for_pic?
    current_user == @log.user
  end
end
