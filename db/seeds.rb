# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



unless Rails.env.production?

	# Create users

	admin = FactoryGirl.create(:user, username: "admin",
	                                 email: "admin@example.com")
	admin.admin!
	admin.activate!

	user = FactoryGirl.create(:user, username: "user",
	                                 email: "user@example.com")
	user.activate!

	david = FactoryGirl.create(:user, username: "david",
	                                  email: "david@example.com")

	5.times do
	  FactoryGirl.create(:random_user)
	end



	# Create Forms

	forms = []
	3.times { forms << FactoryGirl.build(:random_form) }
	user.forms = forms
	user.save!

	form1 = forms.first

	# Create Fields

	field1 = FactoryGirl.build(:text_field, name: "name", label: "Name:")
	field2 = FactoryGirl.build(:textarea_field, name: "biography", label: "Biography:", default: "Enter text here...")

  field3 = FactoryGirl.build(:radio_field, name: "gender", label: "Gender:")
  field3.field_options.build(label: "Male", value: "m")
  field3.field_options.build(label: "Female", value: "f")
  field3.default = field3.field_options.first.value

  #field4 = FactoryGirl.build(:checkbox_field, name: "likes", label: "Likes:")
  #field4.field_options.build(label: "Long walks on the beach", value: "1")
  #field4.field_options.build(label: "Candle lit dinners", value: "2")


	form1.add_field!(field1)
	form1.add_field!(field2)
  form1.add_field!(field3)
  #form1.add_field(field4)

end