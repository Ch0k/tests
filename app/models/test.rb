class Test < ApplicationRecord
  has_many :questions, dependent: :destroy
  belongs_to :category
  has_many :tests_users, dependent: :destroy
  has_many :users, through: :tests_users
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, presence: true, uniqueness: { scope: :level,
  message: "should happen once per level" }
end
