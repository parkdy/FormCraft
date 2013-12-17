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
    var fields = self.get('fields').clone();
    var fieldsSaved = 0;
    var fieldsTotal = fields.length;

    // Save form
    Backbone.Model.prototype.save.call(self, attributes, {
      success: function() {
        // Save form fields
        fields.each(function(field) {
          field.set('form_id', self.get('id'));
          field.save({}, {
            success: function() {
              fieldsSaved++;

              // When all fields are saved
              if (fieldsSaved === fieldsTotal) {
                self.set('fields', fields);
                options.success();
              }
            },
            error: function() { alert('Error saving field'); }
          });
        });
      },
      error: function() { options.error(); }
    });
  }
});
