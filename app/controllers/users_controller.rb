class UsersController < ApplicationController
  before_action :require_login

  def show
    @user = User.find(params[:id])
  end
end
