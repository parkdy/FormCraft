FormBuilder.Collections.Fields = Backbone.Collection.extend({
  model: FormBuilder.Models.Field,
  url: "/api/fields"
});
