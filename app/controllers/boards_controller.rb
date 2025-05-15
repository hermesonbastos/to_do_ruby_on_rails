class BoardsController < ApplicationController
  before_action :require_login
  before_action :set_board, only: %i[show update destroy]

  def index
    @boards = current_user.boards.order(created_at: :desc)
    @board = Board.new
    @columns = @board.columns.order(:position)
    @metrics = UserMetrics.new(current_user)
    @chart_data = @metrics.completed_tasks_per_board
    @task_distribution_data = @metrics.task_distribution_per_board
    @productive_days_data = @metrics.completed_tasks_per_weekday
  end

  def show
    @board = current_user.boards.find(params[:id])
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to board_path(@board)
    else
      @boards = current_user.boards
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @board.update(board_params)
      respond_to do |format|
        format.html { redirect_to boards_path }
        format.turbo_stream
      end
    else
      @boards = current_user.boards.order(created_at: :desc)
      @metrics = UserMetrics.new(current_user)
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy

    respond_to do |format|
      format.html { redirect_to boards_path }
      format.turbo_stream
    end
  end

  private

  def set_board
    @board = current_user.boards.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :description, :banner)
  end
end
