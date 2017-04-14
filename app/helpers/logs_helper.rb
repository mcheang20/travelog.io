module LogsHelper
  def user_is_authorized_for_log?(log)
    current_user && (current_user == log.user || current_user.admin?)
  end
end
