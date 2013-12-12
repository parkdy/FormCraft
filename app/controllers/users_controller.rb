class UsersController < ApplicationController
  before_filter :require_sign_in, except: [:new, :create]
  before_filter :require_admin, only: [:index, :destroy]

  before_filter only: [:edit, :update, :change_password] do |c|
    c.require_correct_user(User.find(params[:id]), { allow_admin: false })
  end

  before_filter only: [:show] do |c|
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

end
