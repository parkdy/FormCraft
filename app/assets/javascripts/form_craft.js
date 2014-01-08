window.FormCraft = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function() {
  	// Bootstrap form JSON
  	var formEditorJSON = JSON.parse($("#form_editor_json").html());

    // Save bootstrapped data in instance variables
  	this.form = new FormCraft.Models.Form(formEditorJSON.form, {parse: true});
    this.fieldTypes = new FormCraft.Collections.Fields(formEditorJSON.fieldTypes, {parse: true});

    // Set default editor tab
    this.editorTab = "add_field";

    // Keep track of models we need to delete when saving the form
    this.deletedFields = new FormCraft.Collections.Fields([]);
    this.deletedFieldOptions = new FormCraft.Collections.FieldOptions([]);

  	// Initialize router
   	new FormCraft.Routers.FormEditorsRouter();
   	Backbone.history.start();

    // User can't save form without sign in
    if (!this.form.get('author_id')) {
      alert("You cannot save and publish forms as a guest.\nPlease sign in to save your work.")
    }
  }
};