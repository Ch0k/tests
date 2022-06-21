# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_test, only: %i[create]

  def create
    @comment = @test.comments.new(comment_params)
    user = current_user
    @tests_users = user.tests_user(@test)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to tests_path, notice: 'Comment was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render 'tests_users/result', status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
    user.add_role :author, @comment
  end

  def index
    @test = Test.find(params[:test_id])
    @comments = @test.comments
  end

  private

  def set_test
    @test = Test.find(params[:test_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
