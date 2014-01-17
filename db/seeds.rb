# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



# Create users

admin = FactoryGirl.create(:user, username: "admin", email: "admin@formcraft.org")
admin.admin!
admin.activate!

user = FactoryGirl.create(:user, username: "user", email: "user@formcraft.org")
user.activate!



# Create Forms

form1 = user.forms.build(title: "Profile Form (pre-made)", 
						 description: "This is a pre-made form to obtain a person's profile information.")
user.forms << form1

50.times do |i|
	user.forms << FactoryGirl.create(:random_form, title: "Random Form " + ("%02d" % (i+1)))
end

user.save!

# Create Fields

field1 = FactoryGirl.build(:text_field, name: "name", label: "Name:")

field2 = FactoryGirl.build(:radio_field, name: "gender", label: "Gender:")
field2.field_options = []
field2.field_options.build(label: "Male", value: "M")
field2.field_options.build(label: "Female", value: "F")

field3 = FactoryGirl.build(:textarea_field, name: "biography", label: "Biography:", default: "Enter text here...")

form1.add_field!(field1)
form1.add_field!(field2)
form1.add_field!(field3)

# Create Responses
response_data = [
	["Batman", "M", "I'm Batman!"],
	["Superman", "M", "I'm unrecognizable in glasses."],
	["Lois Lane", "F", "I'm a terrible journalist."]
]

response_data.each do |rdata|
	response = form1.responses.build
	form1.fields.order(:pos).each_with_index do |field, i|
		response.field_data.build(field_id: field.id, value: rdata[i])
	end
end

form1.save!