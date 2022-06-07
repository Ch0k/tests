class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tests_users
  has_many :tests, through: :tests_users
  validates :email, presence: true, uniqueness: true,  format: { with: URI::MailTo::EMAIL_REGEXP } 

end
