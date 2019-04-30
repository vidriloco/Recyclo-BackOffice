class Api::OffersController < Api::BaseController
  
  before_action :is_authorized
  
  def create    
    @offer = Offer.new(params_for_offer)
    if @offer.save
      render json: { message: "Hemos recibido tu oferta :) En breve te contactaremos para coordinar la recolección." }, status: 200
    else
      render json: { error: @offer.errors.full_messages.first }, status: 400
    end
  end
  
  protected
  
  def params_for_offer
    material_value = offer_params.delete(:material)
    quantity = offer_params.delete(:quantity)
    zone = offer_params.delete(:zone)
    units = offer_params.delete(:units)
    
    material = Material.where(value: material_value).first
    
    { user_id: user_with_token.id, 
      quantity: quantity,
      zone: zone,
      material_id: material.id,
      units: units
    }
  end
  
  def offer_params
    params["offer"] || Hash.new
  end
end
