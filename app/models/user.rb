class User < ActiveRecord::Base
  attr_accessible :email,
                  :username,
                  # :password_digest,
                  # :session_token,
                  # :admin,
                  # :activated,
                  # :activation_token,
                  # :recovery_token,
                  :password, # non-persisted
                  :password_confirmation # non-persisted



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



  # Associations

  has_many(
    :forms,
    class_name: "Form",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :author
  )



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

  # ::generate_recovery_token
  # Returns randomly generated recovery token
  def self.generate_recovery_token
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

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  def reset_activation_token!
    self.activation_token = self.class.generate_activation_token
    self.save!
  end

  def reset_recovery_token!
    self.recovery_token = self.class.generate_recovery_token
    self.save!
  end

  def admin?
    self.admin
  end

  def activated?
    self.activated
  end

  def admin!
    self.admin = true
    self.save!
  end

  def activate!
    self.activated = true
    self.activation_token = nil
    self.save!
  end



  # Helper methods

  private

    # #ensure_session_token
    # Set session token if it doesn't exist
    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end

end
