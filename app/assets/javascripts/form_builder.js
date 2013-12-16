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

  	// Initialize router
   	this.router = new FormBuilder.Routers.FormEditorsRouter({$rootEl: $("#form_editor")});
   	Backbone.history.start();
  }
};