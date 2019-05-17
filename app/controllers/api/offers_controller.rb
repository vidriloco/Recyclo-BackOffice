class Api::OffersController < Api::BaseController
  
  before_action :is_authorized
  
  def create    
    offer, location = Offer.create_with_location(offer_params, location_params, user_with_token)
    
    if offer.persisted? && location.persisted?
      render json: { message: "Hemos recibido tu oferta :) En breve te contactaremos para coordinar la recolección." }, status: 200
    else
      render json: { error: offer.errors.full_messages.first }, status: 400
    end
  end
  
  def index
    offers = current_user_offers
    render json: { offers: offers.map(&:expose_custom_json) }, status: 200
  end
  
  def delete
    Offer.find(params[:id]).destroy
    
    offers = current_user_offers
    render json: { offers: offers.map(&:expose_custom_json) }, status: 200
  end
  
  protected
  
  def current_user_offers
    Offer.where(user_id: user_with_token.id).includes([:location, :material]).order('updated_at DESC')
  end
  
  def offer_params
    params["offer"] || Hash.new
  end
  
  def location_params
    params["location"] || Hash.new
  end
end
