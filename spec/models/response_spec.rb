require 'spec_helper'

describe Response do
  let(:user) { FactoryGirl.create(:user) }
  let(:form) { FactoryGirl.create(:form, author_id: user.id) }
  let(:field) { FactoryGirl.create(:field, form_id: form.id) }

  subject(:response) { FactoryGirl.build(:response) }



  # Attributes

  it { should allow_mass_assignment_of :read }



  # Associations

  it { should have_many :field_data }



  # Validations

  it { should allow_value(true, false).for(:read) }



  it { should be_valid }
end
