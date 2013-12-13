class FormEditorsController < ApplicationController
  def index
    @mode = params[:mode] || "new"
    @form = (params[:form_id] ? Form.find(params[:form_id]) : Form.new(title: "Untitled Form"))
  end
end
