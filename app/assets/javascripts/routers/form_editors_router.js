FormCraft.Routers.FormEditorsRouter = Backbone.Router.extend({
	routes: {
		"" : "formEditorsIndex"
	},

	formEditorsIndex: function() {
		var formEditorsIndex = new FormCraft.Views.FormEditorsIndex({ $el: $("#form_editor") });
		formEditorsIndex.render();
    FormCraft.formEditorsIndex = formEditorsIndex;
	}
});
