# frozen_string_literal: true

class Answer < ApplicationRecord
  resourcify
  belongs_to :question
  validates :answer, presence: true
  validate :validate_answer_count, on: :create
  scope :correct, -> { where(correct: true) }
  scope :author, ->(user) { with_role(:author, user).pluck(:id) }

  private

  def validate_answer_count
    errors.add(:answer_count) if question.answers.count > 4
  end
end
