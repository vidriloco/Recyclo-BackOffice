class Api::SessionsController < Api::BaseController
  def create
    @user = found_user_from_params
    
    if @user.nil?
      render json: { error: "Credenciales no válidas" }, status: 400
    else
      sign_in @user
      render json: { token: @user.remember_token }, status: 200
    end
  end
  
  def found_user_from_params
    login = session_params.delete(:login)
    password = session_params.delete(:password)
    
    user = User.where(username: login).or(User.where(email: login)).first
    
    return if user.nil?
    user.authenticated?(password) ? user : nil
  end

  def session_params
    params["session"] || Hash.new
  end
end
