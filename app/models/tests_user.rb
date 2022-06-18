# frozen_string_literal: true

class TestsUser < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create

  GOOD_RESULT_PROCENT = 85

  def accept!(answer_ids)
    self.correct_question += 1 if correct_answer?(answer_ids)
    self.current_question = next_question
    save!
  end

  def complited?
    current_question.nil?
  end

  def question_number
    test.questions.index { |x| x.body == current_question.body } + 1
  end

  def passed?
    success_rate >= GOOD_RESULT_PROCENT
  end

  private

  def before_validation_set_first_question
    self.current_question = self.test.questions.first if test.present?
  end

  def correct_answer?(answer_ids)
    correct_answer_count = correct_answers.count

    (correct_answer_count == correct_answers.where(id: answer_ids).count) &&
      (correct_answer_count == answer_ids.count)
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    self.test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def success_rate
    correct_questions_multiply_by_100 / test_questions_count
  end

  def correct_questions_multiply_by_100
    correct_question * 100
  end

  def test_questions_count
    test.questions.count
  end
end
