# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tests_users
  has_many :tests, through: :tests_users
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def tests_user(test)
    tests_users.order(id: :desc).find_by(test_id: test.id)
  end

  after_create :assign_default_role
  after_create :assign_default_admin

  def assign_default_role
    self.add_role(:reader) if self.roles.blank?
  end

  def assign_default_admin
    self.add_role(:admin) if User.all.count == 1
  end
end
