class Api::AvatarsController < Api::BaseController
  
  #before_action :is_authorized
  
  def index
    @avatars = Avatar.all
    
    render json: { avatars: @avatars.map(&:expose_custom_json) }, status: 200
  end
end
