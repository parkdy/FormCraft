require 'spec_helper'

describe User do
  subject(:user) { FactoryGirl.build(:user) }

  let(:other_user) do
    FactoryGirl.build(:user, username: "other_user",
                             email: "other_user@example.com")
  end

  before { other_user.save! }



  # Attributes

  it { should allow_mass_assignment_of :username }
  it { should allow_mass_assignment_of :email }
  it { should allow_mass_assignment_of :password }
  it { should allow_mass_assignment_of :password_confirmation }

  it { should_not allow_mass_assignment_of :password_digest }
  it { should_not allow_mass_assignment_of :session_token }
  it { should_not allow_mass_assignment_of :admin }
  it { should_not allow_mass_assignment_of :activated }
  it { should_not allow_mass_assignment_of :activation_token }
  it { should_not allow_mass_assignment_of :recovery_token }



  # Associations

  it { should have_many :forms }



  # Validations

  it { should validate_presence_of :username }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password_digest }
  # it { should validate_presence_of :session_token }
  # User#ensure_session_token breaks this test

  it { should allow_value(true, false).for(:admin) }
  it { should allow_value(true, false).for(:activated) }
  # ensure_inclusion_of can't handle booleans

  it { should validate_uniqueness_of :username }
  it { should validate_uniqueness_of :email }
  it { should validate_uniqueness_of :session_token }



  # Authentication

  it { should have_secure_password }

  describe "with a password shorter than 6 characters" do
    before { user.password = "abcde" }
    it { should_not be_valid }
  end

  describe "with a password confirmation that doesn't match" do
    before { user.password_confirmation = "not_password" }
    it { should_not be_valid }
  end



  it { should be_valid }

  describe "when saved" do
    before { user.save! }

    it "should not persist passwords" do
      # Fetch user from database
      fetched_user = User.find(user)
      expect(fetched_user.password).to be_nil
    end
  end

end
