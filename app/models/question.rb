# frozen_string_literal: true

class Question < ApplicationRecord
  resourcify
  has_many :answers, dependent: :destroy
  belongs_to :test
  validates :body, presence: true

  scope :author, ->(user) { with_role(:author, user).pluck(:id) }
end
