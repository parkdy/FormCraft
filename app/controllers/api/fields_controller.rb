class Api::FieldsController < ApplicationController
  def show
    @field = Field.find(params[:id])

    render json: @field
  end

  def create
    @field = Field.new(params[:field])

    if @field.save
      render json: @field
    else
      render json: { errors: @field.errors.full_messages },
                   status: :unprocessable_entity
    end
  end

  def update
    @field = Field.find(params[:id])

    if @field.update_attributes(params[:field])
      render json: @field
    else
      render json: { errors: @field.errors.full_messages },
                   status: :unprocessable_entity
    end
  end

  def destroy
    @field = Field.find(params[:id])
    @field.destroy

    render json: "Deleted field"
  end
end
