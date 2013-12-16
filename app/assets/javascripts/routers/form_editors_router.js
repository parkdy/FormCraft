FormBuilder.Routers.FormEditorsRouter = Backbone.Router.extend({
	routes: {
		"" : "formEditorsIndex"
	},

	formEditorsIndex: function() {
		var formEditorsIndex = new FormBuilder.Views.FormEditorsIndex();
		formEditorsIndex.render();
	}
});
