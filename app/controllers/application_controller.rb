class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    redirect_to auth_path, alert: "Você precisa estar autenticado para acessar esta página." unless logged_in?
  end

  before_action :set_theme

  def set_theme
    @theme = cookies[:theme] || "custom360"
  end
end
