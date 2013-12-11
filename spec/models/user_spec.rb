require 'spec_helper'

describe User do
  subject(:user) do
    User.new(username: "user",
             email: "user@example.com",
             password: "password",
             password_confirmation: "password")
  end

  let(:other_user) do
    User.new(username: "other_user",
             email: "other_user@example.com",
             password: "password",
             password_confirmation: "password")
  end



  # Attributes

  it { should respond_to :username }
  it { should respond_to :email }
  it { should respond_to :password_digest }
  it { should respond_to :session_token }

  # Methods

  # Authentication methods
  it { should respond_to :password= }
  it { should respond_to :password_confirmation= }
  it { should respond_to :authenticate }

  it { should respond_to :reset_session_token! }



  # Validations

  describe "with blank attributes" do
    subject(:blank_user) { User.new }
    it { should_not be_valid }
  end

  describe "with a blank username" do
    before { user.username = " " }
    it { should_not be_valid }
  end

  describe "with a duplicate username" do
    before do
      other_user.username = "user"
      other_user.save!
    end

    it { should_not be_valid }
  end

  describe "with a blank email" do
    before { user.email = " " }
    it { should_not be_valid }
  end

  describe "with a duplicate email" do
    before do
      other_user.email = "user@example.com"
      other_user.save!
    end

    it { should_not be_valid }
  end

  describe "with a blank password_digest" do
    before { user.password_digest = " " }
    it { should_not be_valid }
  end

  describe "with a blank session_token" do
    before { user.session_token = " " }
    it { should_not be_valid }
  end

  describe "with a duplicate session token" do
    before do
      other_user.reset_session_token!
      user.session_token = other_user.session_token
    end

    it { should_not be_valid }
  end

  describe "with a password shorter than 6 characters" do
    before { user.password = "abcde" }
    it { should_not be_valid }
  end

  describe "with a password confirmation that doesn't match" do
    before { user.password_confirmation = "not_password" }
    it { should_not be_valid }
  end



  describe "with valid attributes" do
    # Valid attributes set in subject method
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
end
