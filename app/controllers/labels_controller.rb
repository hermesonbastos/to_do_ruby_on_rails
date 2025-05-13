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

 # Em app/controllers/labels_controller.rb
def create
  @label = @board.labels.build(label_params)
  @task = Task.find(params[:task_id]) if params[:task_id].present?

  if @label.save
    # Adiciona a etiqueta à tarefa automaticamente
    @task.labels << @label if @task.present?
    
    # Renderiza os partials para as etiquetas
    task_labels_html = render_to_string(
      partial: 'tasks/labels',  # Use o nome correto do seu partial
      locals: { task: @task },
      formats: [:html], # <-- Adicione esta linha!
      layout: false
    )
    
    available_labels_html = render_to_string(
      partial: 'labels/available_labels',
      locals: { board: @board, task: @task },
      formats: [:html], # <-- Adicione esta linha!
      layout: false
    )
    
    # Responde com JSON
    render json: {
      success: true,
      task_id: @task.id,
      task_labels_html: task_labels_html,
      available_labels_html: available_labels_html
    }
  else
    # Responde com erros
    render json: {
      success: false,
      errors: @label.errors.full_messages
    }, status: :unprocessable_entity
  end
end

  def add_to_task
    @label = Label.find(params[:id])

    unless @task.labels.include?(@label)
      @task.labels << @label
    end

    @task.labels.reload
    respond_to do |format|
      format.html { redirect_to board_path(@task.column.board), notice: "Etiqueta adicionada com sucesso." }
      format.turbo_stream
    end
  end

  def remove_from_task
    @label = Label.find(params[:id])
    @task.labels.delete(@label)
    @task.labels.reload
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
