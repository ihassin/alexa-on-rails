class Session < ApplicationRecord
  belongs_to :user

  def log_session session
    session_id = session['sessionId']
    user_id = session['user']['userId']
    store_session_details session_id, user_id
  end

  def store_session_details(session_id, user_id)
    session_id = Session.find_or_create_by(session_id: session_id)
    user = User.find_or_create_by(user_id: user_id)
    user.sessions << session_id
    session_id.session_id
  end
end
