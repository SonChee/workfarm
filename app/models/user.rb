class User < ActiveRecord::Base
  include UserDecorator
	before_save { self.email = email.downcase }
  
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :first_name,  presence: true, length: { maximum: 20 }
  validates :last_name,  presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :code, presence:   true, uniqueness: { case_sensitive: false }
  
end
