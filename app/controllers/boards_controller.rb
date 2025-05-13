class BoardsController < ApplicationController
  before_action :require_login

  def index
    @boards = current_user.boards.order(created_at: :desc)
    @board = Board.new
    @columns = @board.columns.order(:position)
    @daily_streak = DailyStreakService.new(current_user)
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

  private

  def board_params
    params.require(:board).permit(:name, :description, :banner)
  end
end
