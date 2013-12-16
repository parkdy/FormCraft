FormBuilder.Views.FormEditorsFieldSettings = Backbone.View.extend({
  template: JST['form_editors/editor/field_settings'],

  render: function() {
  	var renderedContent = this.template({});
    this.$el.html(renderedContent);

  	return this;
  }

});
