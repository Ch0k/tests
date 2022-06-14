# frozen_string_literal: true

class Test < ApplicationRecord
  has_many :questions, dependent: :destroy
  belongs_to :category
  has_many :tests_users, dependent: :destroy
  has_many :users, through: :tests_users
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, presence: true, uniqueness: { scope: :level,
                                                  message: 'should happen once per level' }

  scope :easy, -> { where(level: 0..1) }
  scope :normal, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }
  scope :list_category, lambda { |category|
                          joins('JOIN categories ON tests.category_id = categories.id').where('categories.title = ? ', category)
                        }
end
