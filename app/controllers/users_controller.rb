class UsersController < ApplicationController
  before_filter :require_sign_in, except: [:new, :create, :activate]
  before_filter :require_admin, only: [:index, :destroy]

  before_filter only: [:edit, :update, :change_password] do |c|
    c.require_correct_user(User.find(params[:id]), { allow_admin: false })
  end

  before_filter only: [:show, :send_activation_email] do |c|
    c.require_correct_user(User.find(params[:id]), { allow_admin: true })
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:success] = "Created new user"
      sign_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  # #update
  # Handles PUT requests from both #edit and #change_password
  def update
    @user = User.find(params[:id])

    if params[:user][:password] && !@user.authenticate(params[:current_password])
      flash.now[:fail] = "Current password incorrect"
      render :change_password
    elsif @user.update_attributes(params[:user])
      flash[:success] = "Updated user"
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages

      # Render change_password or edit template
      render (params[:user][:password] ? :change_password : :edit)
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy
    flash[:success] = "Deleted user"
    redirect_to users_url
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
      @user.reset_activation_token!
      redirect_to root_url
    end

    
  end

end
