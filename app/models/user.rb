class User < ActiveRecord::Base
  attr_accessible :email,
                  :password_digest,
                  :session_token,
                  :username,
                  :admin,
                  :activated,
                  :activation_token,
                  # non-persisted
                  :password,
                  :password_confirmation



  # Before validation callbacks

  before_validation :ensure_session_token



  # has_secure_password adds the following methods:
  #   #password=(passord)
  #   #password_confirmation=(password)
  #   #authenticate(password)
  # and validates:
  #   password
  #   password_confirmation
  #   password_digest

  has_secure_password



  # Validations

  validates :email,
            :session_token,
            :username,
            presence: true

  validates :email,
            :session_token,
            :username,
            uniqueness: true

  # Password must be at least 6 characters long
  validates :password, length: { minimum: 6, allow_nil: true }

  validates :admin, :activated, inclusion: { in: [true, false] }



  # Class methods

  # ::generate_session_token
  # Returns randomly generated session token
  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  # ::generate_activation_token
  # Returns randomly generated activation token
  def self.generate_activation_token
    SecureRandom.urlsafe_base64(16)
  end

  # ::authenticate(username, password)
  # Returns user if username and password authenticated,
  # otherwise return false
  def self.authenticate(username, password)
    user = User.find_by_username(username)
    return false if user.nil?

    # Use has_secure_password method
    user.authenticate(password)
  end



  # Instance methods

  # #reset_session_token!
  # Set new session token and save! user
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  # #reset_activation_token!
  # Set new activation token and save! user
  def reset_activation_token!
    self.activation_token = self.class.generate_activation_token
    self.save!
  end

  # #admin?
  # Returns whether user is admin
  def admin?
    self.admin
  end

  # #admin?
  # Returns whether user is activated
  def activated?
    self.activated
  end



  # Helper methods

  private

    # #ensure_session_token
    # Set session token if it doesn't exist
    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end

end
