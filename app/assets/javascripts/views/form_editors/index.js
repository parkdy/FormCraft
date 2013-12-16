FormBuilder.Views.FormEditorsIndex = Backbone.View.extend({
  template: JST['form_editors/index'],

  render: function() {
    // Render editor tabs
    var $editor_tabs = $('#editor_tabs');
    $editor_tabs.html($(JST["form_editors/editor/tabs"]({})));

    // Grab root elements for our sub-views
    var $editor_view = $('#editor_view');
    var $preview_view = $('#preview_view');

    // Render sub-views

    // Render editor view (based on which tab is open)
    var editorView;

    switch (FormBuilder.editorTab) {
    case "add_field":
      editorView = new FormBuilder.Views.FormEditorsAddField({ $el: $editor_view });
      break;
    case "field_settings":
      editorView = new FormBuilder.Views.FormEditorsFieldSettings({ $el: $editor_view });
      break;
    case "form_settings":
      editorView = new FormBuilder.Views.FormEditorsFormSettings({ $el: $editor_view });
      break;
    }

    this._swapEditorView(editorView);

    // Render preview view
    var previewView = new FormBuilder.Views.FormEditorsPreview({ $el: $preview_view });
    previewView.render();

  	return this;
  },

  _swapEditorView: function (newView) {
    this._currentEditorView && this._currentEditorView.remove();
    this._currentEditorView = newView;
    newView.render();
  }

});
