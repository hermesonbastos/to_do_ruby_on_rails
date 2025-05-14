class OmniauthController < ApplicationController
  def google_oauth2
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth)

    if user.persisted?
      session[:user_id] = user.id
      redirect_to boards_path, notice: "Login com Google efetuado com sucesso."
    else
      redirect_to auth_path, alert: "Não foi possível fazer login com Google."
    end
  end

  def failure
    redirect_to auth_path, alert: "Falha na autenticação com Google."
  end
end
