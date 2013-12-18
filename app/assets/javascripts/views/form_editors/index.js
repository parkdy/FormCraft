FormBuilder.Views.FormEditorsIndex = Backbone.View.extend({
  initialize: function(options) {
    this.$el = options.$el;
  },

  template: JST['form_editors/index'],

  events: {
    "click .editor_tab": "switchEditorTab",
    "click #save_btn": "saveForm",
    "click #discard_btn": "discardForm"
  },

  render: function() {
    // Render editor tabs
    this.renderEditorTabs();

    // Render sub-views
    this.renderEditorView();
    this.renderPreviewView();

  	return this;
  },

  _swapEditorView: function (newView) {
    this._currentEditorView && this._currentEditorView.remove();
    this._currentEditorView = newView;
    $('#editor_view').html(newView.render().$el);
  },

  _swapPreviewView: function (newView) {
    this._currentPreviewView && this._currentPreviewView.remove();
    this._currentPreviewView = newView;
    $('#preview_view').html(newView.render().$el);
  },

  renderEditorTabs: function() {
    var $editorTabs = $('#editor_tabs');
    $editorTabs.html($(JST["form_editors/editor/tabs"]({})));

    // Show which editor tab is active
    $(".editor_tab").removeClass("active_tab");
    $("#"+FormBuilder.editorTab+"_tab").addClass("active_tab");
  },

  renderEditorView: function(options) {
    var editorView;

    switch (FormBuilder.editorTab) {
    case "add_field":
      editorView = new FormBuilder.Views.FormEditorsAddField(options);
      break;
    case "field_settings":
      editorView = new FormBuilder.Views.FormEditorsFieldSettings(options);
      break;
    case "form_settings":
      editorView = new FormBuilder.Views.FormEditorsFormSettings(options);
      break;
    }

    this._swapEditorView(editorView);

    if (FormBuilder.editorTab == 'add_field') {
      $(".field_type_field").draggable({
        containment: "#form_editor",
        revert: true,
        stack: ".draggable"
      });
    }
  },

  renderPreviewView: function() {
    var previewView = new FormBuilder.Views.FormEditorsPreview();
    this._swapPreviewView(previewView);

    $(".preview_field").draggable({
      containment: "#form_editor",
      revert: "invalid",
      stack: ".draggable"
    });
  },

  switchEditorTab: function(event) {
    event.preventDefault();

    // Change editor tab
    var editorTab= $(event.target).attr("data-tab");
    FormBuilder.editorTab = editorTab;

    this.renderEditorTabs();
    this.renderEditorView();

    // Clear active field in preview window
    $(".preview_field").removeClass("active_field");
  },

  saveForm: function(event) {
    event.preventDefault();

    if (confirm('Save your work?')) {
      // Destroy deleted fields
      FormBuilder.deletedFields.each(function(field) {
        field.destroy({ wait: true });
      });
      FormBuilder.deletedFields.reset();

      // Destroy deleted field options
      FormBuilder.deletedFieldOptions.each(function(option) {
        option.destroy({ wait: true });
      });
      FormBuilder.deletedFieldOptions.reset();

      // Save form
      FormBuilder.form.save({}, {
        success: function() { alert("Saved form"); },
        error: function() { alert("Could not save form"); }
      });
    }
  },

  discardForm: function(event) {
    event.preventDefault();

    if (confirm('Discard your work?')) {
      FormBuilder.form.fetch({
        success: function() {
          FormBuilder.formEditorsIndex.render();
        }
      });
    }
  }
});
