class FormEditorsController < ApplicationController
  def index
    @mode = params[:mode] || "new"
    @editor_tab = params[:editor_tab] || "add_field"
    
    if params[:form_id] 
    	@form = Form.includes(:fields).find(params[:form_id])
    else 
    	@form = FactoryGirl.build(:form)
    	@form.author_id = (signed_in? ? current_user.id : nil)
    end
  end
end
