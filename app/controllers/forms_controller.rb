class FormsController < ApplicationController
  def show
    @form = Form.find(params[:id])
  end

  def create
    @form = Form.new(params[:form])

    if @form.save
      flash[:success] = "Created new form"
      redirect_to form_url(@form)
    else
      flash[:errors] = @form.errors.full_messages
      redirect_to user_url(current_user)
    end
  end

  def update
    @form = Form.find(params[:id])

    if @form.update_attributes(params[:form])
      flash[:success] = "Updated form"
      redirect_to form_url(@form)
    else
      flash[:errors] = @form.errors.full_messages
      redirect_to form_url(@form)
    end
  end

  def destroy
    @form = Form.find(params[:id])
    @form.destroy

    flash[:success] = "Deleted form"
    redirect_to user_url(current_user)
  end
end
