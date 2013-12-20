FormCraft.Views.FormEditorsIndex = Backbone.View.extend({
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
    $("#"+FormCraft.editorTab+"_tab").addClass("active_tab");
  },

  renderEditorView: function(options) {
    var editorView;

    switch (FormCraft.editorTab) {
    case "add_field":
      editorView = new FormCraft.Views.FormEditorsAddField(options);
      break;
    case "field_settings":
      editorView = new FormCraft.Views.FormEditorsFieldSettings(options);
      break;
    case "form_settings":
      editorView = new FormCraft.Views.FormEditorsFormSettings(options);
      break;
    }

    this._swapEditorView(editorView);

    if (FormCraft.editorTab == 'add_field') {
      $(".field_type_field").draggable({
        containment: "#form_editor",
        revert: true,
        stack: ".draggable"
      });
    }
  },

  renderPreviewView: function() {
    var previewView = new FormCraft.Views.FormEditorsPreview();
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
    FormCraft.editorTab = editorTab;

    this.renderEditorTabs();
    this.renderEditorView();

    // Clear active field in preview window
    $(".preview_field").removeClass("active_field");
  },

  saveForm: function(event) {
    event.preventDefault();

    if (confirm('Save your work?')) {
      // Destroy deleted fields
      FormCraft.deletedFields.each(function(field) {
        field.destroy({ wait: true });
      });
      FormCraft.deletedFields.reset();

      // Destroy deleted field options
      FormCraft.deletedFieldOptions.each(function(option) {
        option.destroy({ wait: true });
      });
      FormCraft.deletedFieldOptions.reset();

      // Save form
      FormCraft.form.save({}, {
        success: function() { alert("Saved form"); },
        error: function() { alert("Could not save form"); }
      });
    }
  },

  discardForm: function(event) {
    event.preventDefault();


    if (confirm('Discard your work?')) {
      if (FormCraft.form.isNew()) {
        // Navigate to home page
        var url = window.location.href;
        var urlParts = url.split('/');
        window.location.href = urlParts[0] + '//' + urlParts[2];

      } else {
        // Reload form
        FormCraft.form.fetch({
          success: function() {
            FormCraft.formEditorsIndex.render();
          },

          error: function() {
            "Could not fetch form"
          }
        });
      }
    }
  }
});
