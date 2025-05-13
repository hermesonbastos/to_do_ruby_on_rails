class ColumnsController < ApplicationController
  before_action :require_login
  before_action :set_board
  before_action :set_column, only: [ :update, :destroy ]

  def create
    @column = @board.columns.build(column_params)

    if @column.save
      respond_to do |format|
        format.html { redirect_to board_path(@board) }
        format.turbo_stream
      end
    else
      redirect_to board_path(@board), alert: "Erro ao criar coluna"
    end
  end

  def update
    if @column.update(column_params)
      respond_to do |format|
        format.html { redirect_to board_path(@board) }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@column) }
      end
    else
      redirect_to board_path(@board), alert: "Erro ao atualizar coluna"
    end
  end

  def destroy
    @column.destroy

    redirect_to board_path(@board)
  end

  private

  def set_board
    @board = current_user.boards.find(params[:board_id])
  end

  def set_column
    @column = @board.columns.find(params[:id])
  end

  def column_params
    params.require(:column).permit(:name, :position, :is_done_column)
  end
end
