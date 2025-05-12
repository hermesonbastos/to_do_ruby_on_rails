class TasksController < ApplicationController
  before_action :require_login
  before_action :set_column
  before_action :set_task, only: [:show, :update, :destroy]

  def create
    @task = @column.tasks.build(task_params)

    if @task.save
      respond_to do |format|
        format.html { redirect_to board_path(@column.board) }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to board_path(@column.board), alert: "Erro ao criar tarefa" }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_task_errors", partial: "tasks/errors", locals: { task: @task }) }
      end
    end
  end

  def show
    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to board_path(@column.board) }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to board_path(@column.board), alert: "Erro ao atualizar tarefa" }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("edit_task_errors", partial: "tasks/errors", locals: { task: @task }) }
      end
    end
  end

  def destroy
    @column = @task.column
    @task_id = @task.id
    @task.destroy

    respond_to do |format|
      format.html { redirect_to board_path(@column.board) }
      format.turbo_stream
    end
  end

  def reorder
    params[:task_ids].each_with_index do |id, index|
      Task.where(id: id).update_all(position: index)
    end

    head :ok
  end

  def move
    @task = Task.find(params[:id])
    @old_column = @task.column
    @new_column = Column.find(params[:target_column_id])

    @task.update(
      column: @new_column,
      position: @new_column.tasks.maximum(:position).to_i + 1
    )

    respond_to do |format|
      format.html { redirect_to board_path(@new_column.board) }
      format.turbo_stream
    end
  end

  private

  def set_column
    @column = Column.find(params[:column_id])
  end

  def set_task
    @task = @column.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :difficulty, :due_date, :position)
  end
end
