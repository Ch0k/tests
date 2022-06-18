# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: %i[show edit update destroy]
  before_action :set_test, only: %i[create]

  authorize_resource

  def show
    @answers = @question.answers
    @answer = Answer.new
  end

  def edit; end

  def create
    @test = Test.find(params[:test_id])
    @question = @test.questions.new(question_params)
    user = current_user
    respond_to do |format|
      if @question.save
        format.html { redirect_to question_path(@question), notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
    user.add_role :author, @question
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to question_url(@question), notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to test_path(@question.test), notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def set_test
    @test = Test.find(params[:test_id])
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
