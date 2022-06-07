class Test < ApplicationRecord
  has_many :questions
  belongs_to :category
  has_many :tests_users, dependent: :destroy
  has_many :users, through: :tests_users
end
