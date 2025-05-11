class AuthController < ApplicationController
  def new
    @step = params[:step] || "email"
    @user = User.new(email: session[:auth_email])
  end

  def create
    case params[:step]
    when "email"
      email = params[:auth][:email].downcase
      session[:auth_email] = email

      if User.exists?(email:)
        redirect_to auth_path(step: "password")
      else
        @user = User.new(email:)
        @step = "register"
        render :new, status: :unprocessable_entity
      end

    when "password"
      user = User.find_by(email: session[:auth_email])
      if user&.authenticate(params[:auth][:password])
        login!(user)
      else
        flash.now[:alert] = "Senha inválida."
        @step = "password"
        render :new, status: :unprocessable_entity
      end

    when "register"
      @user = User.new(user_params.merge(email: session[:auth_email]))
      if @user.save
        login!(@user)
      else
        @step = "register"
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    reset_session
    redirect_to auth_path, notice: "Você saiu da sua conta."
  end

  private

  def user_params
    params.require(:auth).permit(:name, :password, :password_confirmation)
  end

  def login!(user)
    session[:user_id] = user.id
    session.delete(:auth_email)
    redirect_to dashboard_path, notice: "Login efetuado com sucesso."
  end
end
