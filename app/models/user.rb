class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	
  validates :email, 
    presence: true, 
    format: {with: VALID_EMAIL , message: "invalid"}

  has_many :incomes
  has_many :expences
end
