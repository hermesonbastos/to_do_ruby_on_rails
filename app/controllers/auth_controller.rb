class AuthController < ApplicationController
  def new
    # step: email, password ou register
    @step = params[:step] || "email"
    @user = User.new(email: session[:auth_email])
  end

  def create
    case params[:step]
    when "email"
      email = params[:auth][:email].downcase
      session[:auth_email] = email

      if User.exists?(email: email)
        redirect_to auth_path(step: "password")
      else
        @user = User.new(email: email)
        @step = "register"
        render :new, status: :unprocessable_entity
      end

    when "password"
      user = User.find_by(email: session[:auth_email])
      if user&.authenticate(params[:auth][:password])
        session[:user_id] = user.id
        session.delete(:auth_email)
        redirect_to root_path, notice: "Login efetuado com sucesso."
      else
        flash.now[:alert] = "Senha inválida."
        @step = "password"
        render :new, status: :unprocessable_entity
      end

    when "register"
      @user = User.new(user_params)
      @user.email = session[:auth_email]
      if @user.save
        session[:user_id] = @user.id
        session.delete(:auth_email)
        redirect_to root_path, notice: "Conta criada com sucesso."
      else
        @step = "register"
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def user_params
    params.require(:auth).permit(:name, :password, :password_confirmation)
  end
end
