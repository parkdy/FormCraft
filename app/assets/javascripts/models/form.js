FormBuilder.Models.Form = Backbone.Model.extend({
	urlRoot: "/api/forms",

	parse: function(response) {
		// Create replace fields array with a collection
		response.fields = new FormBuilder.Collections.Fields(response.fields);
		
		return response;
	}
});
