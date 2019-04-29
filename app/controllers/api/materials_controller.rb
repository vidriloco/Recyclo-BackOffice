class Api::MaterialsController < Api::BaseController
  
  before_action :is_authorized
  
  def index
    @materials = Material.all
    
    render json: { materials: @materials.map(&:expose_custom_json) }, status: 200
  end
end
