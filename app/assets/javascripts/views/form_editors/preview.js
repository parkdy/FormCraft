FormBuilder.Views.FormEditorsPreview = Backbone.View.extend({
  template: JST['form_editors/preview'],

  render: function() {
  	var renderedContent = this.template({ form: FormBuilder.form });
    this.$el.html(renderedContent);

  	return this;
  }

});
