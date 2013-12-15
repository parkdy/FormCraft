class FormEditorsController < ApplicationController
  def index
    @params = params
    @mode = params[:mode] || "new"
    @form = (params[:form_id] ? Form.includes(:fields).find(params[:form_id]) : FactoryGirl.build(:form, author_id: current_user.id))
    @editor_tab = params[:editor_tab] || "add_field"
  end
end
