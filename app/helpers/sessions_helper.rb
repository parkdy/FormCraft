module SessionsHelper
  def current_user
    token = session[:session_token]
    @current_user ||= User.find_by_session_token(token)
  end

  def sign_in!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    @current_user = user
  end

  def sign_out!
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

  def logged_in?
    !current_user.nil?
  end
end
