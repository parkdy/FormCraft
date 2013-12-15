require 'spec_helper'

describe Form do
  let(:user) { FactoryGirl.create(:user) }

  subject(:form) { FactoryGirl.build(:form, author_id: user.id) }



  # Attributes

  it { should allow_mass_assignment_of :title }
  it { should allow_mass_assignment_of :description }
  it { should allow_mass_assignment_of :author_id }



  # Associations

  it { should belong_to :author }
  it { should have_many :fields }



  # Validations

  it { should validate_presence_of :title }
  it { should validate_presence_of :author }



  it { should be_valid }

end
