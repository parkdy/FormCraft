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

  def signed_in?
    !current_user.nil?
  end

  def require_sign_in
    unless signed_in?
      flash[:fail] = "You must sign in to do that"
      redirect_to signin_url
    end
  end

  def require_admin
    unless current_user.admin?
      flash[:fail] = "You do not have administrative privileges"
      redirect_to root_url
    end
  end

  def require_correct_user(user, options = {})
    default_options = { allow_admin: true }
    options = default_options.merge(options)

    unless current_user == user || (options[:allow_admin] && current_user.admin?)
      flash[:fail] = "You do not have permission to do that"
      redirect_to root_url
    end
  end
end
