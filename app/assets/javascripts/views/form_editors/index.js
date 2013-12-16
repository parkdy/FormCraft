FormBuilder.Views.FormEditorsIndex = Backbone.View.extend({
  initialize: function(options) {
    this.$el = options.$el;
  },

  template: JST['form_editors/index'],

  events: {
    "click .editor_tab": "switchEditorTab"
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

  switchEditorTab: function(event) {
    event.preventDefault();
    var editorTab= $(event.target).attr("data-tab");
    FormBuilder.editorTab = editorTab;

    this.renderEditorView();
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
  }

});
