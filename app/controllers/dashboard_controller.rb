class DashboardController < ApplicationController
  before_action :require_login
  layout "authenticated"

  def index
    # exemplos futuros:
    # @boards = current_user.boards
  end
end
