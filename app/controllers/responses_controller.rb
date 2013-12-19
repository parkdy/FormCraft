class ResponsesController < ApplicationController
  def new
    @form = Form.includes(:fields).find(params[:form_id])
    @response = @form.responses.build
  end

  def create
    @form = Form.find(params[:form_id])
    @response = @form.responses.build

    params[:response].map do |name, value|
      @response.field_data.build(
        value: value,
        field_id: Field.find_by_name(name).id
      )
    end

    if @response.save
      flash[:success] = "Submitted form response"
      redirect_to root_url
    else
      flash.now[:errors] = @response.errors.full_messages
      render :new
    end
  end
end
