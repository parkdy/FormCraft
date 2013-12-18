require 'spec_helper'

describe FieldOption do
  let(:user) { FactoryGirl.create(:user) }
  let(:form) { FactoryGirl.create(:form, author_id: user.id) }
  let(:field) { FactoryGirl.create(:field, form_id: form.id) }

  subject(:field_option) { FactoryGirl.build(:field_option, field_id: field.id) }



  # Attributes

  it { should allow_mass_assignment_of :field_id }
  it { should allow_mass_assignment_of :value }
  it { should allow_mass_assignment_of :label }
  it { should allow_mass_assignment_of :default }



  # Associations

  it { should belong_to :field }



  # Validations

  it { should validate_presence_of :field }
  it { should validate_presence_of :value }
  it { should validate_presence_of :label }

  it { should allow_value(true, false).for(:default) }



  it { should be_valid }
end
