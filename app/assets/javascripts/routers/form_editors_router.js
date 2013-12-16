FormBuilder.Routers.FormEditorsRouter = Backbone.Router.extend({
	routes: {
		"" : "formEditorsIndex"
	},

	formEditorsIndex: function() {
		var formEditorsIndex = new FormBuilder.Views.FormEditorsIndex({ $el: $("#form_editor") });
		formEditorsIndex.render();
    FormBuilder.formEditorsIndex = formEditorsIndex;
	}
});
