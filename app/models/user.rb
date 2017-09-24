class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :database_authenticatable, :authentication_keys => [:login]

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	
  validates :email, 
    presence: true, 
    format: {with: VALID_EMAIL , message: "invalid"}

   validates :user_name,
    presence: true

  validates_uniqueness_of :user_name, 
    :case_sensitive => false,
    :message => " is already taken",
    :if => lambda{ user_name.present? }

  validates :user_name,
    :format => { 
    :with => /[a-zA-Z0-9_]*[a-zA-Z][a-zA-Z0-9_-]/,
    :message => " is invalid" 
    },:if => lambda{ user_name.present? }

  has_many :categories
  has_many :projects

  def login=(login)
    @login = login
  end

  def login
    @login || self.user_name || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(user_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end
