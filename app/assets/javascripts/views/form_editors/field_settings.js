FormBuilder.Views.FormEditorsFieldSettings = Backbone.View.extend({
  initialize: function(options) {
    this.field = options.field;
  },

  template: JST['form_editors/editor/field_settings'],

  events: {
    "blur .settings_field": "updateField",
    "click #update_settings_btn": "dummyButton",
    "click #add_option_btn": "addFieldOption",
    "click .delete_option_btn": "deleteFieldOption"
  },

  render: function() {
    // Don't render settings form without a field
    if (!this.field) {
      this.$el.html("No field selected")
      return this;
    }

    // Settings form fields
    var settingsFields = new FormBuilder.Collections.Fields([
      { field_type: "text", name: "label", label: "Label:", default: this.field.get('label') },
      { field_type: "text", name: "name", label: "Name (unique):", default: this.field.get('name') }
    ]);

    // Add default value settings
    var defaultField = this.field.clone();
    defaultField.set('label', 'Default Value:');
    defaultField.set('name', 'default');
    settingsFields.push(defaultField.attributes);

    // Render
  	var renderedContent = this.template({field: this.field,
                                         settingsFields: settingsFields});
    this.$el.html(renderedContent);

  	return this;
  },

  updateField: function(event) {
    var fieldAttr = $(event.target).closest('.settings_field').attr('data-name');
    var value = $(event.target).val();

    if (fieldAttr == 'default' && this.field.get('field_type') == 'checkbox') {
      this.updateCheckboxDefault(event);
    } else if (fieldAttr == 'field_options_settings') {
      this.updateFieldOptionsSettings(event);
    } else {
      // No field options
      this.field.set(fieldAttr, value);
    }

    FormBuilder.formEditorsIndex.renderPreviewView();
  },

  dummyButton: function(event) {
    event.preventDefault();
  },

  updateCheckboxDefault: function(event) {
    var options = this.field.get('field_options');

    // Wrap default value settings field in form
    var $form = $('<form></form>');
    $form.html($(event.target).closest('.settings_field').clone());

    // Grab default values from form
    var defaultValues = $form.serializeJSON().default;
    defaultValues.shift();

    // Set field options' default properties
    options.each(function(option) {
      var isDefault = (defaultValues.indexOf(option.get('value')) > -1);
      option.set('default', isDefault);
    });
  },

  updateFieldOptionsSettings: function(event) {
    var options = this.field.get('field_options');

    // Wrap options settings in form
    var $form = $('<form></form>');
    $form.html($(event.target).closest('.settings_field').clone());

    // Grab options settings from form
    var optionsSettings = $form.serializeJSON();

    // Find option by cid and set its properties
    for (var cid in optionsSettings) {
      var option = options.get({cid: cid});
      option.set(optionsSettings[cid])
    };

    FormBuilder.formEditorsIndex.renderEditorView({field: this.field});
  },

  addFieldOption: function(event) {
    event.preventDefault();

    var options = this.field.get('field_options');
    var optionValue = (options.length+1).toString();
    var newOption = new FormBuilder.Models.FieldOption({label: "Option"+optionValue, value: optionValue});
    options.add(newOption);

    FormBuilder.formEditorsIndex.renderEditorView({field: this.field});
  },

  deleteFieldOption: function(event) {
    event.preventDefault();

    var options = this.field.get('field_options');

    // Find field option we want to delete
    var optionCID = $(event.target).closest('tr').attr('data-option_cid');
    var option = options.get({cid: optionCID});

    // Delete it
    options.remove(option);
    FormBuilder.deletedFieldOptions.add(option);

    FormBuilder.formEditorsIndex.renderEditorView({field: this.field});
    FormBuilder.formEditorsIndex.renderPreviewView();
  }

});
