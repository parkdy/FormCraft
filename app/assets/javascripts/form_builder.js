window.FormBuilder = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function() {
  	// Bootstrap form JSON
  	var formEditorJSON = JSON.parse($("#form_editor_json").html());
  	this.form = new FormBuilder.Models.Form(formEditorJSON["form"]);
  	this.mode = formEditorJSON["mode"];
  	this.editorTab = formEditorJSON["editorTab"];

  	console.log(this.form)

  	// Initialize router
   	this.router = new FormBuilder.Routers.FormEditorsRouter();
   	Backbone.history.start();
  }
};