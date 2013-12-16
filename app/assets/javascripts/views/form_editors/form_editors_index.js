FormBuilder.Views.FormEditorsIndex = Backbone.View.extend({

  template: JST['form_editors/index'],

  render: function() {
  	var renderedContent = this.template({ form: FormBuilder.form });
  	this.$el.html(renderedContent);
  	
  	return this;
  }

});
