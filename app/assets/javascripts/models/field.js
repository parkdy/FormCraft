FormBuilder.Models.Field = Backbone.Model.extend({
	urlRoot: "/api/fields",

	parse: function(response) {
		// Store field options as a collection
		response.field_options = new FormBuilder.Collections.FieldOptions(response.field_options);

		return response;
	},

  save: function(attributes, options) {
    var self = this;
    var fieldOptions = self.get('field_options').clone();
    var fieldOptionsSaved = 0;
    var fieldOptionsTotal = fieldOptions.length;

    // Save field
    Backbone.Model.prototype.save.call(self, attributes, {
      success: function() {
        if (fieldOptionsTotal === 0) {
          options.success();
        }

        // Save field options
        for (var i = 0; i < fieldOptionsTotal; i++) {
          var fieldOption = fieldOptions.at(i);
          fieldOption.set('field_id', self.get('id'));

          fieldOption.save({}, {
            success: function() {
              fieldOptionsSaved++;

              // When all fields are saved
              if (fieldOptionsSaved === fieldOptionsTotal) {
                self.set('field_options', fieldOptions);
                options.success();
              }
            },
            error: function() { alert('Error saving field option'); }
          });
        }
      },
      error: function() { options.error(); }
    });
  }
});
