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
      respond_to do |format|
        format.html do
          flash[:fail] = "You must sign in to do that"
          redirect_to signin_url
        end

        format.json do
          render json: { errors: ["You must sign in to do that"] },
                       status: :unauthorized
        end
      end
    end
  end

  def require_sign_out
    if signed_in?
      flash[:fail] = "You must sign out to do that"
      redirect_to root_url
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
      respond_to do |format|
        format.html do
          flash[:fail] = "You do not have permission to do that"
          redirect_to root_url
        end

        format.json do
          render json: { errors: ["You must sign in to do that"] },
                       status: :unauthorized
        end
      end
    end
  end

  def require_activation
    unless current_user.activated?
      notice = ("You must activate your account! Please check your email for activation instructions or " +
                "<a href='"+send_activation_email_user_url(current_user)+"'>resend activation email</a>.")

      flash[:notice] = notice.html_safe
      redirect_to user_url(current_user)
    end
  end

end
