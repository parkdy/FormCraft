FormBuilder.Views.FormEditorsAddField = Backbone.View.extend({
  template: JST['form_editors/editor/add_field'],

  events: {
    "click .field_type_add_btn": "addField"
  },

  render: function() {
  	var renderedContent = this.template({});
    this.$el.html(renderedContent);

  	return this;
  },

  addField: function(event) {
    event.preventDefault();
    $button = $(event.target);

    var field_type = $button.closest('.field_type').attr('data-type');

    // Clone field prototype
    var newField = FormBuilder.fieldTypes
                              .findWhere({field_type: field_type})
                              .clone();

    newField.set('pos', FormBuilder.form.get('fields').length);
    newField.set('name', field_type + newField.cid);

    // Add new field to form fields
    FormBuilder.form.get('fields').add(newField);
    FormBuilder.formEditorsIndex.renderPreviewView();
  }

});
