# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy]

  authorize_resource

  def show; end

  def new
    @answer = Answer.new
  end

  def edit; end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    user = current_user
    respond_to do |format|
      if @answer.save
        format.html { redirect_to question_path(@answer.question), notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
    user.add_role :author, @answer
  end

  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to question_path(@answer.question), notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to question_path(@answer.question), notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:answer, :correct)
  end
end
