FormBuilder.Views.FormEditorsPreview = Backbone.View.extend({
  template: JST['form_editors/preview'],

  events: {
    "click .delete_field_btn": "deleteField",
    "click .preview_field": "editField",
    "mousedown .preview_field": "dragField"
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
    // This prevented radio buttons from working in preview window
    // event.preventDefault();

    // Find field
    var $field = $(event.target).closest('.preview_field');
    var fieldPos = parseInt($field.attr('data-pos'));
    var field = FormBuilder.form.get('fields').at(fieldPos);

    // Open its field settings tab
    FormBuilder.editorTab = "field_settings";
    var indexView = FormBuilder.formEditorsIndex;
    indexView.renderEditorTabs();
    indexView.renderEditorView({field: field});

    // Highlight active field
    $(".preview_field").removeClass("active_field");
    $field.addClass("active_field");
  },

  dragField: function(event) {

    $previewField = $(event.target).closest('.preview_field');
    $previewField.draggable({
      containment: "#form_editor",
      revert: "invalid"
    });

    $(".preview_field").droppable({
      tolerance: "pointer",
      drop: function(event, ui) {
        var oldPos = parseInt($previewField.attr('data-pos'));
        var newPos = parseInt($(event.target).attr('data-pos'));

        // Move field
        var fields = FormBuilder.form.get('fields');
        var field = fields.at(oldPos);
        fields.remove(field);
        fields.add(field, {at: newPos, merge: true});

        // Re-render preview
        FormBuilder.formEditorsIndex.renderPreviewView();
      }
    });
  }

});
