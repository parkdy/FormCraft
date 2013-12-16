FormBuilder.Models.Form = Backbone.Model.extend({
	urlRoot: "/api/forms",

	parse: function(response) {
		// Sort fields by position
		response.fields = response.fields.sort(function(field1, field2) {
			return (field1.pos - field2.pos);
		});

		// Then store it as a collection
		response.fields = new FormBuilder.Collections.Fields(response.fields);
		
		return response;
	}
});
