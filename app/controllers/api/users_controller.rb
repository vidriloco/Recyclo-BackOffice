class Api::UsersController < Api::BaseController
  
  before_action :is_authorized, only: [:show]
  
  def create
    @user = user_from_params
    
    if @user.save
      sign_in @user
      render json: { token: @user.remember_token }, status: 200
    else
      render json: { error: @user.errors.full_messages.first }, status: 400
    end
  end
  
  def show
    user = user_with_token
    render json: { user: user.expose_custom_json }, status: 200
  end
  
  def update
    user = user_with_token
    if user.updated_attributes?(user_params)
      render json: { token: user.remember_token }, status: 200
    else
      render json: { error: user.errors.full_messages.first }, status: 400
    end
  end
  
  protected
  def user_from_params
    Clearance.configuration.user_model.new.tap do |user|
      user.name = param_for(:name)
      user.username = param_for(:username)
      user.email = param_for(:email)
      user.password = param_for(:password)
      user.phone = param_for(:phone)
    end
  end
  
  def param_for(field)
    user_params.delete(field)
  end

  def user_params
    params[Clearance.configuration.user_parameter] || Hash.new
  end
end
