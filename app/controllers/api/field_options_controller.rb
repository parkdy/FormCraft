class Api::FieldOptionsController < ApplicationController
  before_filter :require_sign_in, only: [:show, :update, :destoy]

  before_filter only: [:show ,:update, :destroy] do |c|
    c.require_correct_user(FieldOption.find(params[:id]).field.form.author, allow_admin: true)
  end



  def show
    @field_option = FieldOption.find(params[:id])

    render json: @field_option
  end

  def create
    @field_option = FieldOption.new(params[:field_option])

    if @field_option.save
      render json: @field_option
    else
      render json: { errors: @field_option.errors.full_messages },
                   status: :unprocessable_entity
    end
  end

  def update
    @field_option = FieldOption.find(params[:id])

    if @field_option.update_attributes(params[:field_option])
      render json: @field_option
    else
      render json: { errors: @field_option.errors.full_messages },
                   status: :unprocessable_entity
    end
  end

  def destroy
    @field_option = FieldOption.find(params[:id])
    @field_option.destroy

    render json: "Deleted field option"
  end
end
