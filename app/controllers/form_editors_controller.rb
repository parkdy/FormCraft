class FormEditorsController < ApplicationController
  before_filter do |c|
    params[:form_id] && c.require_correct_user(Form.find(params[:form_id]).author, allow_admin: true)
  end

  before_filter do |c|
    signed_in? && c.require_activation
  end



  def index
    if params[:form_id]
    	@form = Form.includes(fields: [:field_options]).find(params[:form_id])
    else
    	@form = FactoryGirl.build(:form)
    	@form.author_id = (signed_in? ? current_user.id : nil)
    end

    # Create field types
    @field_types = field_types(@form)
  end



  private

    def field_types(form)
      field_types = %w{text textarea radio checkbox select}

      field_types.map do |type|
        FactoryGirl.build((type+"_field").to_sym, form_id: form.id, pos: nil)
      end
    end
end
