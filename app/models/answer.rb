class Answer < ApplicationRecord
  belongs_to :question
  validates :answer, presence: true
  validate :validate_answer_count, on: :create

  private

  def validate_answer_count
    errors.add(:answer_count) if question.answers.count > 4
  end
end
