class FormsController < ApplicationController
  before_filter :require_sign_in, only: [:show, :create, :update, :destroy]

  before_filter only: [:update, :destroy] do |c|
    c.require_correct_user(Form.find(params[:id]).author, allow_admin: true)
  end

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

  def new
    redirect_to form_editor_url(mode: "new")
  end

  def edit
    @form = Form.find(params[:id])
    redirect_to form_editor_url(mode: "edit", form_id: @form.id)
  end

  def preview
    @form = Form.find(params[:id])
    redirect_to form_editor_url(mode: "preview", form_id: @form.id)
  end
end
