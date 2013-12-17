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
	},

  save: function(attributes, options) {
    var self = this;
    var fieldsSaved = 0;
    var fieldsTotal = self.get('fields').length;

    // Save form fields
    self.get('fields').each(function(field) {
      field.save({}, {
        success: function() {
          fieldsSaved++;

          // When all fields are saved
          if (fieldsSaved === fieldsTotal) {
            // Save form
            Backbone.Model.prototype.save.call(self, attributes, {
              success: function() { options.success(); },
              error: function() { options.error(); }
            });
          }
        },

        error: function() { alert('Error saving form'); }
      });
    });
  }
});
