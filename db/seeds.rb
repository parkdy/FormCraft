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

50.times do
  FactoryGirl.create(:random_user)
end



# Create Forms

forms = []
50.times { forms << FactoryGirl.build(:random_form) }
user.forms = forms

form1 = forms.first
form1.title = "Profile Form"
form1.description = "This is a form to obtain a person's profile."

user.save!

# Create Fields

field1 = FactoryGirl.build(:text_field, name: "name", label: "Name:")
field2 = FactoryGirl.build(:textarea_field, name: "biography", label: "Biography:", default: "Enter text here...")

field3 = FactoryGirl.build(:radio_field, name: "gender", label: "Gender:")
field3.field_options = []
field3.field_options.build(label: "Male", value: "M")
field3.field_options.build(label: "Female", value: "F")

field4 = FactoryGirl.build(:checkbox_field, name: "likes", label: "Likes:")
field4.field_options = []
field4.field_options.build(label: "Long walks on the beach", value: "Long walks on the beach")
field4.field_options.build(label: "Candle lit dinners", value: "Candle lit dinners")

field5 = FactoryGirl.build(:select_field, name: "favorite food", label: "Favorite Food:")
field5.field_options = []
field5.field_options.build(label: "Pizza", value: "pizza")
field5.field_options.build(label: "Ice Cream", value: "ice cream")
field5.field_options.build(label: "Chocolate", value: "chocolate")

form1.add_field!(field1)
form1.add_field!(field2)
form1.add_field!(field3)
form1.add_field!(field4)
form1.add_field!(field5)