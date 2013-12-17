FormBuilder.Views.FormEditorsPreview = Backbone.View.extend({
  template: JST['form_editors/preview'],

  events: {
    "click .delete_field_btn": "deleteField",
    "click .edit_field_btn": "editField",
    "click .insert_field_btn": "insertField"
  },

  render: function() {
  	var renderedContent = this.template({ form: FormBuilder.form });
    this.$el.html(renderedContent);

  	return this;
  },

  deleteField: function(event){
    event.preventDefault();

    // Get field model we need to delete
    var $field = $(event.target).closest('.preview_field');
    var field_pos = parseInt($field.attr('data-pos'));
    var field = FormBuilder.form.get('fields').findWhere({pos: field_pos});

    // Delete it
    FormBuilder.form.get('fields').remove(field);
    FormBuilder.deletedFields.add(field);

    // Update other field's positions
    FormBuilder.form.get('fields').each(function(field, pos) {
      field.set('pos', pos);
    });

    // Render preview
    FormBuilder.formEditorsIndex.renderPreviewView();
  },

  editField: function(event){
    event.preventDefault();

    // Find field
    var $field = $(event.target).closest('.preview_field');
    var field_pos = parseInt($field.attr('data-pos'));
    var field = FormBuilder.form.get('fields').findWhere({pos: field_pos});

    // Open its field settings tab
    FormBuilder.editorTab = "field_settings";
    FormBuilder.formEditorsIndex.renderEditorView({field: field})
  },

  insertField: function(event){
    event.preventDefault();
    alert('insert');
  },

});
