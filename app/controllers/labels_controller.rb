class LabelsController < ApplicationController
  before_action :require_login
  before_action :set_board, only: [ :index, :create ]
  before_action :set_label, :set_task, only: [ :remove_from_task, :add_to_task ]

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
    @task = Task.find(params[:task_id]) if params[:task_id].present?

    if @label.save
      @task.labels << @label if @task.present?

      task_labels_html = render_to_string(
        partial: "tasks/labels",
        locals: { task: @task },
        formats: [ :html ],
        layout: false
      )

      available_labels_html = render_to_string(
        partial: "labels/available_labels",
        locals: { board: @board, task: @task },
        formats: [ :html ],
        layout: false
      )

      render json: {
        success: true,
        task_id: @task.id,
        task_labels_html: task_labels_html,
        available_labels_html: available_labels_html
      }
    else
      render json: {
        success: false,
        errors: @label.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

 def add_to_task
    @task.labels << @label unless @task.labels.include?(@label)
    @task.labels.reload

    board = @task.column.board

    task_labels_html = render_to_string(
      partial: "tasks/labels",
      locals: { task: @task },
      formats: [ :html ],
      layout: false
    )

    available_labels_html = render_to_string(
      partial: "labels/available_labels",
      locals: { board: board, task: @task },
      formats: [ :html ],
      layout: false
    )

    respond_to do |format|
      format.json do
        render json: {
          success: true,
          task_id: @task.id,
          task_labels_html: task_labels_html,
          available_labels_html: available_labels_html
        }
      end

      format.html { redirect_to board_path(board), notice: "Etiqueta adicionada com sucesso." }
    end
 end

  def remove_from_task
    @task.labels.delete(@label)
    @task.labels.reload

    board = @task.column.board

    task_labels_html = render_to_string(
      partial: "tasks/labels",
      locals: { task: @task },
      formats: [ :html ],
      layout: false
    )

    available_labels_html = render_to_string(
      partial: "labels/available_labels",
      locals: { board: board, task: @task },
      formats: [ :html ],
      layout: false
    )

    respond_to do |format|
      format.json do
        render json: {
          success: true,
          task_id: @task.id,
          task_labels_html: task_labels_html,
          available_labels_html: available_labels_html
        }
      end

      format.html { redirect_to board_path(board), notice: "Etiqueta removida com sucesso." }
    end
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:title, :color)
  end
end
