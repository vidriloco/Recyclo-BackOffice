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
      user.name = user_param_for(:name)
      user.username = user_param_for(:username)
      user.email = user_param_for(:email)
      user.password = user_param_for(:password)
      user.phone = user_param_for(:phone)
      user.campaign_code = campaign_param_for(:code)
      user.via_campaign = campaign_param_for(:enabled)
    end
  end
  
  def user_param_for(field)
    user_params.delete(field)
  end

  def user_params
    params[Clearance.configuration.user_parameter] || Hash.new
  end
  
  def campaign_param_for(field)
    campaign_params.delete(field)
  end
  
  def campaign_params
    params["campaign"] || Hash.new
  end
end
