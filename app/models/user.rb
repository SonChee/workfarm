class User < ActiveRecord::Base
  include UserDecorator
  CREATE_COLUMNS_FOR_ADMINS = [:type, :code, :first_name, :last_name, :email, :password, 
    :password_confirmation, :address]
  UPDATABLE_COLUMNS_FOR_ADMINS = [:type, :code, :first_name, :last_name, :email, :address]
  UPDATABLE_COLUMNS_FOR_USERS = [:type, :code, :first_name, :last_name, :email, :address]

	before_save { self.email = email.downcase }
  before_create :create_remember_token

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :first_name,  presence: true, length: { maximum: 20 }
  validates :last_name,  presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :code, presence:   true, uniqueness: { case_sensitive: false }
  
  has_many :master_tasks, class_name: "Task" ,foreign_key: :taskmaster_id
  has_many :assign_tasks, class_name: "Task" ,foreign_key: :assignee_id
  has_many :position_in_farms
  has_many :farms, through: :position_in_farms
  belongs_to :big_farm, class_name: "Farm" ,foreign_key: :current_big_farm_id

  class << self

    def list_types user_type
      if user_type == "Admin"
        list_types = ["Admin","Member"]
      end
    end
    
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
