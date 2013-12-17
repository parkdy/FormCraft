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

    // Keep track of fields we need to delete
    this.deletedFields = new FormBuilder.Collections.Fields([]);

  	// Initialize router
   	new FormBuilder.Routers.FormEditorsRouter();
   	Backbone.history.start();
  }
};