class UsersController < ApplicationController
  before_filter :require_sign_in, only: [:index, :show, :edit, :update, :destroy,
                                         :change_password, :send_activation_email]
  before_filter :require_sign_out, only: [:new, :create, :forgot_password, :send_recovery_email]

  before_filter :require_admin, only: [:index, :destroy]

  before_filter only: [:edit, :update, :change_password] do |c|
    c.require_correct_user(User.find(params[:id]), { allow_admin: false })
  end

  before_filter only: [:show, :send_activation_email] do |c|
    c.require_correct_user(User.find(params[:id]), { allow_admin: true })
  end



  def index
    @users = User.order(:username).page(params[:page])
    @page = params[:page]
  end

  def show
    @user = User.find(params[:id])
    @forms = @user.forms.order(:title).page(params[:page])
    @page = params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in!(@user)
      redirect_to send_activation_email_user_url(@user, flash: "Created new user")
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  # #update
  # Handles PUT requests from #edit, #change_password, and #reset password
  def update
    @user = User.find(params[:id])

    if params[:user][:password] && params[:current_password] && !@user.authenticate(params[:current_password])
      flash.now[:fail] = "Current password incorrect"
      render :change_password
    elsif @user.update_attributes(params[:user])
      flash[:success] = "Updated user"
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages

      # Render appropriate template
      if params[:user][:password] && params[:current_user]
        render :change_password
      elsif params[:user][:password]
        render :reset_password
      else
        render :edit
      end
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy
    flash[:success] = "Deleted user"
    redirect_to users_url(page: params[:page])
  end

  # #change_password
  # Show form to change password
  def change_password
    @user = User.find(params[:id])
  end

  # #send_activation_email
  # Send activation email
  def send_activation_email
    @user = User.find(params[:id])

    if @user.activated?
      flash[:fail] = "Account already activated"

    else
      begin
        @user.reset_activation_token!
        UserMailer.activation_email(@user).deliver!

        flash[:success] = "Activation email sent"
      rescue StandardError => e
        flash[:errors] = ["Unable to send activation email", e.message]
      end
    end

    if params[:flash]
      flash[:success] = params[:flash] + ". " + flash[:success]
    end

    redirect_to user_url(@user)
  end

  # #activate
  # Activate user by checking activation token
  def activate
    @user = User.find(params[:id])

    if @user.activated?
      flash[:fail] = "Account already activated"
      redirect_to root_url

    elsif @user.activation_token && params[:activation_token] == @user.activation_token
      @user.activated = true
      @user.activation_token = nil

      if @user.save
        flash[:success] = "Activated account"
        sign_in!(@user)
        redirect_to user_url(@user)
      else
        flash[:errors] = ["Unable to activate account"] + @user.errors.full_messages
        redirect_to root_url
      end

    else
      flash[:fail] = "Invalid activation token"
      redirect_to root_url
    end

  end

  # #forgot_password
  # Show form to begin password recovery process
  def forgot_password
    @user = User.new
  end

  # #send_recovery_email
  # Send recovery email
  def send_recovery_email
    @user = User.find_by_email(params[:user][:email])

    if @user
      begin
        @user.reset_recovery_token!
        UserMailer.recovery_email(@user).deliver!

        flash[:success] = "Recovery email sent"
      rescue StandardError => e
        flash[:errors] = ["Unable to send recovery email", e.message]
      end

      redirect_to signin_url
    else
      flash.now[:fail] = "User not found"
      render :forgot_password
    end
  end

  def reset_password
    @user = User.find(params[:id])

    if @user.nil?
      flash[:error] = "User not found"
      redirect_to root_url

    elsif @user.recovery_token && params[:recovery_token] == @user.recovery_token
      @user.recovery_token = nil

      if @user.save
        sign_in!(@user)
        render :reset_password
      else
        flash[:errors] = @user.errors.full_messages
        redirect_to root_url
      end

    else
      flash[:fail] = "Invalid recovery token"
      redirect_to root_url
    end
  end

end
