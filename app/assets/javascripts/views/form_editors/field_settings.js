FormBuilder.Views.FormEditorsFieldSettings = Backbone.View.extend({
  initialize: function(options) {
    this.field = options.field;
  },

  template: JST['form_editors/editor/field_settings'],

  events: {
    "blur .settings_field": "updateField",
    "click #update_settings_btn": "dummyButton"
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
      { field_type: "text", name: "name", label: "Name (must be unique):", default: this.field.get('name') }
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

    // Default value for checkbox fields
    var options = this.field.get('field_options');

    if (fieldAttr == 'default' && this.field.get('field_type') == 'checkbox') {

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

    } else {
      // No field options
      this.field.set(fieldAttr, value);
    }

    FormBuilder.formEditorsIndex.renderPreviewView();
  },

  dummyButton: function(event) {
    event.preventDefault();
  }

});
