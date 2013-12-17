require 'spec_helper'

describe Field do
  let(:user) { FactoryGirl.create(:user) }
  let(:form) { FactoryGirl.create(:form, author_id: user.id) }
  let(:other_field) { FactoryGirl.create(:field, form_id: form.id) }

  subject(:field) { FactoryGirl.build(:field, form_id: form.id) }

  # Attributes

  it { should allow_mass_assignment_of :field_type }
  it { should allow_mass_assignment_of :form_id }
  it { should allow_mass_assignment_of :label }
  it { should allow_mass_assignment_of :default }
  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :pos }


  # Associations

  it { should belong_to :form }
  it { should have_many :field_options }



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



  it { should be_valid }
end
