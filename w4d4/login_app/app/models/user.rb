class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}
  before_validation :ensure_session_token

  attr_reader :password

  # def before_validation
  # ensure_session_token
  #   pass = User.session[:password_digest]
  #   pass.length { min: 6, allow_nil: true }
  # end

  def find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user &&
    BCrypt::Password.new(user.password_digest).is_password?(password)
      return user
    end
    nil
  end

# forgot the self here...
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16) # => 16 is the default if n isn't specified
  end

  def reset_session_token
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
    # @session_token ||= SecureRandom::urlsafe_base_64
    # current_user[:session_token] == @session_token
    # @session_token = nil
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
    # @password = BCrypt::Password.create(pass)
  end

end
