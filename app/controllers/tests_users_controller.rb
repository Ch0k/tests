# frozen_string_literal: true

class TestsUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_test, only: %i[show update result]

  def show; end

  def update
    @tests_users.accept!(params[:answer_ids])
    if @tests_users.complited?
      # TestsMailer.complited_test(@user_test).deliver_now
      redirect_to result_tests_user_path(@tests_users)
    else
      render :show
    end
  end

  def result
    @tests_users = TestsUser.find(params[:id])
    @test = @tests_users.test
    @comment = Comment.new
  end

  private

  def set_user_test
    @tests_users = TestsUser.find(params[:id])
  end
end
