require 'spec_helper'

describe Response do
  let(:user) { FactoryGirl.create(:user) }
  let(:form) { FactoryGirl.create(:form, author_id: user.id) }
  let(:field) { FactoryGirl.create(:field, form_id: form.id) }

  subject(:response) { FactoryGirl.build(:response, form_id: form.id) }



  # Attributes

  it { should allow_mass_assignment_of :read }
  it { should allow_mass_assignment_of :form_id }



  # Associations

  it { should have_many :field_data }
  it { should belong_to :form }



  # Validations

  it { should validate_presence_of :form }
  it { should allow_value(true, false).for(:read) }



  it { should be_valid }
end
