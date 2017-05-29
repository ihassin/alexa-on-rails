class AlexaIntent
  def log_session session_info
    Session.new.log_session session_info
  end
end
