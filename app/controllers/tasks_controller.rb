class TasksController < ApplicationController
  before_action :require_login, :set_column
  before_action :set_task, only: [ :show, :update, :destroy, :move ]

  def create
    @task = @column.tasks.build(task_params)

    if @task.save
      if current_user.provider == "google_oauth2"
        GoogleCalendarService.new(current_user).create_or_update_event_for_task(@task)
      end

      respond_to do |format|
        format.html { redirect_to board_path(@column.board) }
        format.turbo_stream
      end

      respond_to do |format|
        format.html { redirect_to board_path(@column.board) }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to board_path(@column.board) }
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
      if current_user.provider == "google_oauth2"
        GoogleCalendarService.new(current_user).create_or_update_event_for_task(@task)
      end

      respond_to do |format|
        format.html { redirect_to board_path(@column.board) }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to board_path(@column.board) }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("edit_task_errors", partial: "tasks/errors", locals: { task: @task }) }
      end
    end
  end

  def destroy
    if current_user.provider == "google_oauth2" && @task.google_event_id.present?
      GoogleCalendarService.new(current_user).delete_event_for_task(@task)
    end

    @task.destroy
    redirect_to board_path(@task.column.board)
  end

  def move
    @old_column = @task.column
    @new_column = Column.find(params[:target_column_id])

    if @task.update(column: @new_column, position: params[:newPosition])
      head :ok
    else
      render json: { error: "Failed to move task" }, status: :unprocessable_entity
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
    params.require(:task).permit(:title, :description, :difficulty, :due_date, :position, label_ids: [])
  end
end
