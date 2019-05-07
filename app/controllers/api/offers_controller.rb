class Api::OffersController < Api::BaseController
  
  before_action :is_authorized
  
  def create    
    offer = Offer.new(params_for_offer)
    location = Location.new(params_for_location)
    
    ActiveRecord::Base.transaction do
      if location.save!
        offer.location_id = location.id
        offer.save!
      end
    end
    
    if offer.persisted? && location.persisted?
      render json: { message: "Hemos recibido tu oferta :) En breve te contactaremos para coordinar la recolección." }, status: 200
    else
      render json: { error: offer.errors.full_messages.first }, status: 400
    end
  end
  
  def index
    offers = Offer.where(user_id: user_with_token.id).includes([:location, :material]).order('updated_at DESC')
    render json: { offers: offers.map(&:expose_custom_json) }, status: 200
  end
  
  protected
  
  def params_for_location
    place = location_params.delete(:place)
    formatted_address = place.delete(:formatted_address)
    location = place.delete(:geometry).delete(:location)
    place_id = place.delete(:place_id)
    
    {
      place_identifier: place_id,
      user_id: user_with_token.id,
      lat: location.delete(:lat),
      lng: location.delete(:lng),
      address: formatted_address,
      zone: location_params.delete(:zone)
    }
  end
  
  def params_for_offer
    material_value = offer_params.delete(:material)
    quantity = offer_params.delete(:quantity)
    units = offer_params.delete(:units)
    
    material = Material.where(value: material_value).first
    
    { 
      user_id: user_with_token.id, 
      quantity: quantity,
      material_id: material.id,
      units: units
    }
  end
  
  def offer_params
    params["offer"] || Hash.new
  end
  
  def location_params
    params["location"] || Hash.new
  end
end
