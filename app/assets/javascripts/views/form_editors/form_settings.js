FormBuilder.Views.FormEditorsFormSettings = Backbone.View.extend({
  template: JST['form_editors/editor/form_settings'],

  events: {
    "blur .settings_field": "updateForm",
    "click #update_settings_btn": "dummyButton"
  },

  render: function() {
    var settingsFields = new FormBuilder.Collections.Fields([
      { field_type: "text", name: "title", label: "Title:", default: FormBuilder.form.get('title') },
      { field_type: "textarea", name: "description", label: "Description:", default: FormBuilder.form.get('description') }
    ]);

  	var renderedContent = this.template({ form: FormBuilder.form,
                                          settingsFields: settingsFields });
    this.$el.html(renderedContent);

  	return this;
  },

  updateForm: function(event) {
    var formAttr = $(event.target).closest('.settings_field').attr('data-name');
    var value = $(event.target).val();

    FormBuilder.form.set(formAttr, value);

    FormBuilder.formEditorsIndex.renderPreviewView();
  },

  dummyButton: function(event) {
    event.preventDefault();
  }

});
