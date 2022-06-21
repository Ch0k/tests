# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :authenticate_user!, only: %i[new start edit show update destroy create upvote downvote]
  before_action :set_test, only: %i[show edit update destroy start upvote downvote]
  
  authorize_resource

  def index
    @tests = Test.all
  end

  def show
    @questions = @test.questions
    @question = Question.new
  end

  def new
    @test = Test.new
  end

  def edit; end

  def create
    @test = Test.new(test_params)
    user = current_user
    respond_to do |format|
      if @test.save
        format.html { redirect_to test_url(@test), notice: 'Test was successfully created.' }
        format.json { render :show, status: :created, location: @test }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    user.add_role :author, @test
    end
  end

  def update
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to test_url(@test), notice: 'Test was successfully updated.' }
        format.json { render :show, status: :ok, location: @test }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @test.destroy

    respond_to do |format|
      format.html { redirect_to tests_url, notice: 'Test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def start
    if @test.questions.present?
      current_user.tests.push(@test)
      redirect_to current_user.tests_user(@test)
    else
      redirect_to root_path, notice: 'Тест не возможно начать. У теста нет вопросов'
    end
  end

  def upvote
    if current_user.voted_up_on? @test
      @test.unvote_by current_user
    else
      @test.upvote_by current_user
    end
    render "vote.js.erb"
  end

  def downvote
    if current_user.voted_down_on? @test
      @test.unvote_by current_user
    else
      @test.downvote_by current_user
    end
    render "vote.js.erb"
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :category_id, :level)
  end
end
