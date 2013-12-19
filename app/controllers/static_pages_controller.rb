class StaticPagesController < ApplicationController
  # Home page
  def index
    redirect_to user_url(current_user) if signed_in?
  end
end
