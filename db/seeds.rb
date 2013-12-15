# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



# Create users

admin = User.create!(
  username: "admin",
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password"
)
admin.admin!
admin.activate!

guest = User.create!(
  username: "guest",
  email: "guest@example.com",
  password: "password",
  password_confirmation: "password"
)

user = User.create!(
  username: "user",
  email: "user@example.com",
  password: "password",
  password_confirmation: "password"
)
user.activate!

david = User.create!(
  username: "david",
  email: "david@example.com",
  password: "password",
  password_confirmation: "password"
)



# Create Forms

form1 = user.forms.build(title: "Form 1",
                         description: "My first form!")

form2 = user.forms.build(title: "Form 2",
                         description: "Another form!")

form2 = user.forms.build(title: "Form 3",
                         description: "One\nTwo\nThree")

user.save!



# Create Fields

field1 = Field.new( field_type: "text",
                    name: "name", 
                    label: "Name:")

field2 = Field.new( field_type: "text",
                    name: "email", 
                    label: "Email:")

field3 = Field.new( field_type: "text",
                    name: "subject", 
                    label: "Subject:")

field4 = Field.new( field_type: "text",
                    name: "body", 
                    label: "Body:", 
                    default: "Enter text here...")

form1.add_field!(field1)
form1.add_field!(field3)
form1.insert_field!(field2, 1)
form1.insert_field!(field4, 1)
form1.move_field!(1, 3)