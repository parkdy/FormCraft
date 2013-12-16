class Api::FormsController < ApplicationController
  def show
    @form = Form.find(params[:id])

    render json: @form
  end

  def create
    @form = Form.new(params[:form])

    if @form.save
      render json: @form
    else
      render json: { errors: @form.errors.full_messages },
                   status: :unprocessable_entity
    end
  end

  def update
    @form = Form.find(params[:id])

    if @form.update_attributes(params[:form])
      render json: @form
    else
      render json: { errors: @form.errors.full_messages },
                   status: :unprocessable_entity
    end
  end

  def destroy
    @form = Form.find(params[:id])
    @form.destroy

    render json: "Deleted form"
  end
end
