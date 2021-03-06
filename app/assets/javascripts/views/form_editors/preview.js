FormCraft.Views.FormEditorsPreview = Backbone.View.extend({
  template: JST['form_editors/preview'],

  events: {
    "click .delete_field_btn": "deleteField",
    "mousedown .preview_field": "editOrDragField",
    "click #submit_btn": "dummyButton"
  },

  render: function() {
  	var renderedContent = this.template({ form: FormCraft.form });
    this.$el.html(renderedContent);

  	return this;
  },

  deleteField: function(event){
    event.preventDefault();

    // Get field model we need to delete
    var $field = $(event.target).closest('.preview_field');
    var field_pos = parseInt($field.attr('data-pos'));
    var field = FormCraft.form.get('fields').findWhere({pos: field_pos});

    // Delete it
    FormCraft.form.get('fields').remove(field);
    FormCraft.deletedFields.add(field);

    // Update other field's positions
    FormCraft.form.get('fields').each(function(field, pos) {
      field.set('pos', pos);
    });

    // Render preview
    FormCraft.formEditorsIndex.renderPreviewView();
  },

  editOrDragField: function(event) {
    this.editField(event);
    this.dragField(event);
  },

  editField: function(event){
    // This prevented radio buttons from working in preview window
    // event.preventDefault();

    // Find field
    var $field = $(event.target).closest('.preview_field');
    var fieldPos = parseInt($field.attr('data-pos'));
    var field = FormCraft.form.get('fields').at(fieldPos);

    // Open its field settings tab
    FormCraft.editorTab = "field_settings";
    var indexView = FormCraft.formEditorsIndex;
    indexView.renderEditorTabs();
    indexView.renderEditorView({field: field});

    // Highlight active field
    $(".preview_field").removeClass("active_field");
    $field.addClass("active_field");
  },

  dragField: function(event) {

    $previewField = $(event.target).closest('.preview_field');

    $(".field_slot").droppable({
      tolerance: "pointer",
      drop: function(event, ui) {
        var oldPos = parseInt($previewField.attr('data-pos'));
        var newPos = parseInt($(event.target).attr('data-pos'));

        // Move field
        var fields = FormCraft.form.get('fields');
        var field = fields.at(oldPos);
        fields.remove(field);
        fields.add(field, {at: newPos, merge: true});

        // Re-render preview
        FormCraft.formEditorsIndex.renderPreviewView();

        // Highlight active field
        $(".preview_field").removeClass("active_field");
        $(".preview_field[data-pos="+newPos+"]").addClass("active_field");
      }
    });
  },

  dummyButton: function(event) {
    event.preventDefault();
  }

});
