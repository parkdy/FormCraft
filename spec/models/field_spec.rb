require 'spec_helper'

describe Field do
  let(:user) do
    User.new(username: "user",
             email: "user@example.com",
             password: "password",
             password_confirmation: "password")
  end

  let(:form) do
    user.forms.build(title: "Test Form",
                     description: "A form for testing")
  end

  let(:other_field) do
    form.fields.build(field_type: "text",
                      label: "Other Label:",
                      default: "Default Value",
                      name: "other_name")
  end

  before do
    form.fields << other_field
    user.forms << form
    user.save!
  end

  subject(:field) do
    form.fields.build(field_type: "text",
                      label: "Name:",
                      default: "Default Value",
                      name: "name")
  end

  # Attributes

  it { should allow_mass_assignment_of :field_type }
  it { should allow_mass_assignment_of :form_id }
  it { should allow_mass_assignment_of :label }
  it { should allow_mass_assignment_of :default }
  it { should allow_mass_assignment_of :name }


  # Associations

  it { should belong_to :form }



  # Validations

  it { should validate_presence_of :field_type }
  it { should validate_presence_of :form }
  it { should validate_presence_of :name }

  it { should ensure_inclusion_of(:field_type).in_array(Field.types) }

  describe "with duplicate field names in a form" do
    before do
      field.name = other_field.name

    end

    it { should_not be_valid }
  end



  it { should be_valid }
end
