class LabelsController < ApplicationController
  before_action :require_login
  before_action :set_board, only: [ :index, :create ]
  before_action :set_task, only: [ :add_to_task, :remove_from_task ]

  def index
    @labels = @board.labels
    @task = Task.find(params[:task_id]) if params[:task_id].present?

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    @label = @board.labels.build(label_params)

    if @label.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to board_path(@board) }
      end
    else
      respond_to do |format|
        format.html { render :index, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_label_form", partial: "labels/form", locals: { label: @label, board: @board }) }
      end
    end
  end

  def add_to_task
    @label = Label.find(params[:id])

    unless @task.labels.include?(@label)
      @task.labels << @label
    end

    respond_to do |format|
      format.html { redirect_to board_path(@task.column.board), notice: "Etiqueta adicionada com sucesso." }
      format.turbo_stream
    end
  end

  def remove_from_task
    @label = Label.find(params[:id])
    @task.labels.delete(@label)

    respond_to do |format|
      format.html { redirect_to board_path(@task.column.board), notice: "Etiqueta removida com sucesso." }
      format.turbo_stream
    end
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  def label_params
    params.require(:label).permit(:title, :color)
  end
end
