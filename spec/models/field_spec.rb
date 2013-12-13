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

  before { user.save! }

  subject(:field) do
    form.fields.build(type: "text",
                      label: "Name:",
                      default: "Default Value")
  end

  # Attributes

  it { should allow_mass_assignment_of :type }
  it { should allow_mass_assignment_of :form_id }
  it { should allow_mass_assignment_of :label }
  it { should allow_mass_assignment_of :default }


  # Associations

  it { should belong_to :form }



  # Validations

  it { should validate_presence_of :type }
  it { should validate_presence_of :form }

  it { should ensure_inclusion_of(:type).in_array(Field.types) }



  it { should be_valid }
end
