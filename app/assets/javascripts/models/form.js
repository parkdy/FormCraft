FormCraft.Models.Form = Backbone.Model.extend({
	urlRoot: "/api/forms",

	parse: function(response) {
		// Sort fields by position
		response.fields = response.fields.sort(function(field1, field2) {
			return (field1.pos - field2.pos);
		});

		// Then store it as a collection
		response.fields = new FormCraft.Collections.Fields(response.fields);

    // Store each field's options as a collection
    response.fields.each(function(field) {
      field.set('field_options', new FormCraft.Collections.FieldOptions(field.get('field_options')));
    });

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
        if (fieldsTotal === 0) {
          options.success();
        }

        // Save form fields
        for (var i = 0; i < fieldsTotal; i++) {
          var field = fields.at(i);
          field.set('form_id', self.get('id'));
          field.set('pos', i);

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
        }
      },
      error: function() { options.error(); }
    });
  }
});
