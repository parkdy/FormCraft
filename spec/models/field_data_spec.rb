require 'spec_helper'

describe FieldData do
  let(:user) { FactoryGirl.create(:user) }
  let(:form) { FactoryGirl.create(:form, author_id: user.id) }
  let(:field) { FactoryGirl.create(:field, form_id: form.id) }
  let(:response) { FactoryGirl.create(:response) }

  subject(:field_data) do
    FactoryGirl.build(:field_data, field_id: field.id,
                                   response_id: response.id)
  end



  # Attributes

  it { should allow_mass_assignment_of :field_id }
  it { should allow_mass_assignment_of :response_id }
  it { should allow_mass_assignment_of :value }



  # Associations

  it { should belong_to :field }
  it { should belong_to :response }



  # Validations

  it { should validate_presence_of :field }
  it { should validate_presence_of :response }



  it { should be_valid }
end
