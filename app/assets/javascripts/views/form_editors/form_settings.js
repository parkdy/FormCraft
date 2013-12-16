FormBuilder.Views.FormEditorsFormSettings = Backbone.View.extend({
  initialize: function(options) {
    this.$el = options.$el;
  },

  template: JST['form_editors/editor/form_settings'],

  render: function() {
  	var renderedContent = this.template({});
    this.$el.html(renderedContent);

  	return this;
  }

});
