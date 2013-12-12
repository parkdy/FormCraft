class SessionsController < ApplicationController
  before_filter :require_sign_in, only: [:destroy]
  before_filter :require_sign_out, only: [:new, :create]

  def new
  end

  def create
    user = User.authenticate(params[:user][:username],
                              params[:user][:password])

    if user
      sign_in!(user)
      flash[:success] = "Signed in as #{user.username}"
      redirect_to user_url(user)
    else
      flash.now[:fail] = "Invalid login"
      render :new
    end
  end

  def destroy
    sign_out!
    flash[:success] = "Signed out"
    redirect_to root_url
  end
end
