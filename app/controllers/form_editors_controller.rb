class FormEditorsController < ApplicationController
  def index
    @params = params
    @mode = params[:mode] || "new"
    @form = (params[:form_id] ? Form.find(params[:form_id]) : Form.new(title: "Untitled Form"))
    @editor_tab = params[:editor_tab] || "add_field"
  end
end
