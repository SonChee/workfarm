class User < ActiveRecord::Base
  include UserDecorator
	before_save { self.email = email.downcase }
  before_create :create_remember_token
  
  has_secure_password
  validates :type,  presence: true
  validates :password, length: { minimum: 6 }
  validates :first_name,  presence: true, length: { maximum: 20 }
  validates :last_name,  presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :code, presence:   true, uniqueness: { case_sensitive: false }
  
  class << self
    def new_remember_token
      SecureRandom.urlsafe_base64
    end

    def hash_string token
      Digest::SHA1.hexdigest(token.to_s)
    end
  end

  private

    def create_remember_token
      self.remember_token = User.hash_string(User.new_remember_token)
    end
end
