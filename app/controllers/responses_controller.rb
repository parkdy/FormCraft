class ResponsesController < ApplicationController
  def new
    @response = Response.new
  end

  def create
    @response = Response.new(params[:response])

    if @response.save
      flash[:success] = "Responded to form"
      redirect_to root_url
    else
      flash.now[:errors] = @response.errors.full_messages
      render :new
    end
  end
end
