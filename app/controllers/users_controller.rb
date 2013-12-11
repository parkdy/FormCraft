class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    if @user.nil?
      flash[:error] = "user not found"
      redirect_to root_url
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.nil?
      flash[:error] = "user not found"
      redirect_to root_url
    elsif @user.save
      flash[:success] = "created new user"
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.nil?
      flash[:error] = "user not found"
      redirect_to root_url
    elsif @user.updateAttributes(params[:user])
      flash[:success] = "updated user"
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.nil?
      flash[:error] = "user not found"
      redirect_to root_url
    else
      @user.destroy
      flash[:success] = "deleted user"
      redirect_to users_url
    end
  end
end
