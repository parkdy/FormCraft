class ResponsesController < ApplicationController
  before_filter :require_sign_in, only: [:index, :destroy]

  before_filter only: [:index, :destroy] do |c|
    c.require_correct_user(Form.find(params[:form_id]).author, allow_admin: true)
  end



  def new
    @form = Form.includes(:fields).find(params[:form_id])
    @response = @form.responses.build
  end

  def create
    @form = Form.includes(:fields).find(params[:form_id])
    @response = @form.responses.build

    @form.fields.each do |field|
      value = params[:response][field.name] || ""

      if value.is_a?(Array)
        value.delete("")
        value = value.to_json
      end

      @response.field_data.build(
        value: value,
        field_id: field.id
      )
    end

    if @response.save
      flash[:success] = "Submitted form response"
      redirect_to new_form_response_url(form_id: params[:form_id])
    else
      flash.now[:errors] = @response.errors.full_messages
      render :new
    end
  end

  def index
    @form = Form.includes(:fields).includes(:responses).find(params[:form_id])
    @responses = @form.responses.order(:created_at).page(params[:page])
    @page = params[:page]

    respond_to do |format|
      format.csv { render text: @form.responses_csv }
      format.xls { render partial: "shared/responses_table", locals: { form: @form } }
    end
  end

  def destroy
    @response = Response.find(params[:id])
    @response.destroy

    flash[:success] = "Deleted response"
    redirect_to form_url(params[:form_id], page: params[:page])
  end
end
