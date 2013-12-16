FormBuilder.Routers.FormEditorsRouter = Backbone.Router.extend({
	initialize: function(options) {
		this.$rootEl = options.$rootEl;
	},

	routes: {
		"" : "formEditorsIndex"
	},

	_swapView: function (newView) {
	  this._currentView && this._currentView.remove();
	  this._currentView = newView;
	  this.$rootEl.html(newView.render().$el);
	},

	formEditorsIndex: function() {
		var formEditorsIndex = new FormBuilder.Views.FormEditorsIndex();
		this._swapView(formEditorsIndex);
	}
});
