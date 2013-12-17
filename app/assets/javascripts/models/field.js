FormBuilder.Models.Field = Backbone.Model.extend({
	urlRoot: "/api/fields",

	parse: function(response) {
		// Store field options as a collection
		response.field_options = new FormBuilder.Collections.FieldOptions(response.field_options);

		return response;
	}
});
