window.FormBuilder = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function() {
  	// Bootstrap form JSON
  	var formEditorJSON = JSON.parse($("#form_editor_json").html());
  	this.form = new FormBuilder.Models.Form(formEditorJSON.form, {parse: true});
    this.fieldTypes = new FormBuilder.Collections.Fields(formEditorJSON.fieldTypes, {parse: true});

    this.editorTab = "add_field";

    // Keep track of models we need to delete
    this.deletedFields = new FormBuilder.Collections.Fields([]);
    this.deletedFieldOptions = new FormBuilder.Collections.FieldOptions([]);

  	// Initialize router
   	new FormBuilder.Routers.FormEditorsRouter();
   	Backbone.history.start();

    // User can't save form without sign in
    if (!this.form.get('author_id')) {
      alert("You cannot save and publish forms as a guest.\nPlease sign in to save your work.")
    }
  }
};