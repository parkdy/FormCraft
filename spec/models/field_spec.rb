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
                      name: "other_name",
                      pos: 0)
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
                      name: "name",
                      pos: 1)
  end

  # Attributes

  it { should allow_mass_assignment_of :field_type }
  it { should allow_mass_assignment_of :form_id }
  it { should allow_mass_assignment_of :label }
  it { should allow_mass_assignment_of :default }
  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :pos }


  # Associations

  it { should belong_to :form }



  # Validations

  it { should validate_presence_of :field_type }
  it { should validate_presence_of :form }
  it { should validate_presence_of :name }

  it { should ensure_inclusion_of(:field_type).in_array(Field.types) }

  it { should validate_numericality_of(:pos).only_integer }
  it { should validate_numericality_of(:pos).is_greater_than_or_equal_to(0) }

  describe "with duplicate field names in a form" do
    before { field.name = other_field.name }
    it { should_not be_valid }
  end

  describe "with duplicate field positions in a form" do
    before { field.pos = other_field.pos }
    it { should_not be_valid }
  end



  it { should be_valid }
end
