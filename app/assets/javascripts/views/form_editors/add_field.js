FormBuilder.Views.FormEditorsAddField = Backbone.View.extend({
  initialize: function(options) {
    this.$el = options.$el;
  },

  template: JST['form_editors/editor/add_field'],

  render: function() {
  	var renderedContent = this.template({});
    this.$el.html(renderedContent);

  	return this;
  }

});
