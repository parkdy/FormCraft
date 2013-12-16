FormBuilder.Views.FormEditorsFormSettings = Backbone.View.extend({
  template: JST['form_editors/editor/form_settings'],

  render: function() {
  	var renderedContent = this.template({});
    this.$el.html(renderedContent);

  	return this;
  }

});
