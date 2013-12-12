require 'spec_helper'

describe Form do
  let(:user) do
    User.new(username: "user",
             email: "user@example.com",
             password: "password",
             password_confirmation: "password")
  end

  before { user.save! }

  subject(:form) { Form.new(title: "Test Form", description: "A form for testing", author_id: user.id) }



  # Attributes

  it { should allow_mass_assignment_of :title }
  it { should allow_mass_assignment_of :description }
  it { should allow_mass_assignment_of :author_id }



  # Associations

  it { should belong_to :author }



  # Validations

  it { should validate_presence_of :title }
  it { should validate_presence_of :author }



  it { should be_valid }

end
