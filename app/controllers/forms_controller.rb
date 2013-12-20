class FormsController < ApplicationController
  before_filter :require_sign_in, only: [:show, :create, :update, :destroy, :edit]

  before_filter only: [:show, :edit, :update, :destroy] do |c|
    c.require_correct_user(Form.find(params[:id]).author, allow_admin: true)
  end

  def show
    @form = Form.includes(:responses).find(params[:id])
    @responses = @form.responses.order(:created_at).page(params[:page])
  end

  def destroy
    @form = Form.find(params[:id])
    @form.destroy

    flash[:success] = "Deleted form"
    redirect_to user_url(current_user)
  end

  def new
    redirect_to form_editor_url
  end

  def edit
    @form = Form.find(params[:id])
    redirect_to form_editor_url(form_id: @form.id)
  end
end
