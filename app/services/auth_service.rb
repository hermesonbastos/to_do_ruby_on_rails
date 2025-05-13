class AuthService
  def initialize(session)
    @session = session
  end

  def process_email_step(email)
    email = email.downcase
    @session[:auth_email] = email

    if User.exists?(email: email)
      { redirect_to: :password }
    else
      { render: :register, user: User.new(email: email) }
    end
  end

  def process_password_step(password)
    user = User.find_by(email: @session[:auth_email])

    if user&.authenticate(password)
      login_user(user)
    else
      { render: :password, alert: "Senha inválida." }
    end
  end

  def process_register_step(user_params)
    user = User.new(user_params.merge(email: @session[:auth_email]))

    if user.save
      login_user(user)
    else
      { render: :register, user: user }
    end
  end

  private

  def login_user(user)
    @session[:user_id] = user.id
    @session.delete(:auth_email)

    { redirect_to: :boards, notice: "Login efetuado com sucesso." }
  end
end
