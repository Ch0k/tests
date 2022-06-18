# frozen_string_literal: true

class Category < ApplicationRecord
  resourcify
  has_many :tests
  validates :title, presence: true
end
