class Api::FormsController < ApplicationController
  before_filter :require_sign_in, only: [:show, :update, :destoy]

  before_filter only: [:show ,:update, :destroy] do |c|
    c.require_correct_user(Form.find(params[:id]).author, allow_admin: true)
  end



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
