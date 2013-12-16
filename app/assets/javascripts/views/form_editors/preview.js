FormBuilder.Views.FormEditorsPreview = Backbone.View.extend({
  initialize: function(options) {
    this.$el = options.$el;
  },

  template: JST['form_editors/preview'],

  render: function() {
  	var renderedContent = this.template({ form: FormBuilder.form });
    this.$el.html(renderedContent);

  	return this;
  }

});
