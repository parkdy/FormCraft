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
    var $editorTabs = $('#editor_tabs');
    $editorTabs.html($(JST["form_editors/editor/tabs"]({})));

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

  renderEditorView: function() {
    var editorView;

    switch (FormBuilder.editorTab) {
    case "add_field":
      editorView = new FormBuilder.Views.FormEditorsAddField();
      break;
    case "field_settings":
      editorView = new FormBuilder.Views.FormEditorsFieldSettings();
      break;
    case "form_settings":
      editorView = new FormBuilder.Views.FormEditorsFormSettings();
      break;
    }

    this._swapEditorView(editorView);
  },

  renderPreviewView: function() {
    var previewView = new FormBuilder.Views.FormEditorsPreview();
    this._swapPreviewView(previewView);
  },

  switchEditorTab: function(event) {
    event.preventDefault();
    var editorTab= $(event.target).attr("data-tab");
    FormBuilder.editorTab = editorTab;

    this.renderEditorView();
  },

  saveForm: function(event) {
    event.preventDefault();

    if (confirm('Save your work?')) {
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
