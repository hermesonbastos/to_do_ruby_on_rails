class AuthController < ApplicationController
  def new
    @step = params[:step] || "email"
    @user = User.new(email: session[:auth_email])
  end

  def create
    auth_service = AuthService.new(session)
    
    case params[:step]
    when "email"
      result = auth_service.process_email_step(params[:auth][:email])
      
      if result[:redirect_to] == :password
        redirect_to auth_path(step: "password")
      else
        @user = result[:user]
        @step = "register"
        render :new, status: :unprocessable_entity
      end
      
    when "password"
      result = auth_service.process_password_step(params[:auth][:password])
      
      if result[:redirect_to]
        login!(result)
      else
        flash.now[:alert] = result[:alert]
        @step = "password"
        render :new, status: :unprocessable_entity
      end
      
    when "register"
      result = auth_service.process_register_step(user_params)
      
      if result[:redirect_to]
        login!(result)
      else
        @user = result[:user]
        @step = "register"
        render :new, status: :unprocessable_entity
      end
    end
  end


  private

  def user_params
    params.require(:auth).permit(:name, :password, :password_confirmation)
  end

  def login!(result)
    redirect_to boards_path, notice: result[:notice]
  end
end