class Api::UsersController < Api::BaseController
  def create
    @user = user_from_params
    
    if @user.save
      sign_in @user
      render json: { token: @user.remember_token }, status: 200
    else
      render json: { error: @user.errors.full_messages.first }, status: 400
    end
  end
  
  def user_from_params
    name = user_params.delete(:name)
    username = user_params.delete(:username)
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    phone = user_params.delete(:phone)

    Clearance.configuration.user_model.new.tap do |user|
      user.name = name
      user.username = username
      user.email = email
      user.password = password
      user.phone = phone
    end
  end

  def user_params
    params[Clearance.configuration.user_parameter] || Hash.new
  end
end
