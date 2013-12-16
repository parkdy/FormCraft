window.FormBuilder = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function() {
  	// Bootstrap form JSON
  	var formEditorJSON = JSON.parse($("#form_editor_json").html());
  	this.form = new FormBuilder.Models.Form(formEditorJSON.form, {parse: true});
  	this.mode = formEditorJSON.mode;
  	this.editorTab = formEditorJSON.editorTab;
    this.fieldTypes = new FormBuilder.Collections.Fields(formEditorJSON.fieldTypes);

  	// Initialize router
   	new FormBuilder.Routers.FormEditorsRouter();
   	Backbone.history.start();
  }
};