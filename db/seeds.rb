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
	field2 = FactoryGirl.build(:text_field, name: "email", label: "Email:")
	field3 = FactoryGirl.build(:text_field, name: "subject", label: "Subject:")
	field4 = FactoryGirl.build(:textarea_field, name: "body", label: "Body:", default: "Enter text here...")

	form1.add_field!(field1)
	form1.add_field!(field3)
	form1.insert_field!(field2, 1)
	form1.insert_field!(field4, 1)
	form1.move_field!(1, 3)
	
end