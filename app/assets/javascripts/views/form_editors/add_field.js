FormCraft.Views.FormEditorsAddField = Backbone.View.extend({
  template: JST['form_editors/editor/add_field'],

  events: {
    "click .field_type_add_btn": "addField",
    "mousedown .field_type_field": "dragAddField"
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
    var newField = FormCraft.fieldTypes
                              .findWhere({field_type: field_type})
                              .clone();

    // Clone field's options
    var newFieldOptions = _.map(newField.get('field_options').models,
                                function(option) { return option.clone(); });
    newField.set('field_options', new FormCraft.Collections.FieldOptions(newFieldOptions));

    // Set field's unique name
    newField.set('name', field_type + newField.cid);

    // Add new field to form fields
    FormCraft.form.get('fields').add(newField);
    FormCraft.formEditorsIndex.renderPreviewView();
  },

  dragAddField: function(event) {
    var field_type = $(event.target).closest('.field_type').attr('data-type');

    $(".field_slot").droppable({
      tolerance: "pointer",
      drop: function(event, ui) {
        var newPos = parseInt($(event.target).attr('data-pos'));

        // Create field and drop it in desired position
        var newField = FormCraft.fieldTypes
                                  .findWhere({field_type: field_type})
                                  .clone();
        newField.set('name', field_type + newField.cid);
        FormCraft.form.get('fields').add(newField, {at: newPos});

        // Re-render preview
        FormCraft.formEditorsIndex.renderPreviewView();
      }
    });
  }

});
