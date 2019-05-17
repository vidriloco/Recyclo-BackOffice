class Offer < ApplicationRecord
  module Units
    BAGS = "bags"
    PIECES = "pieces"
    KILOS = "kilos"
  end
  
  module Status
    PENDING_REVIEW = "pending_review"
    REVIEWING = "reviewing"
    COORDINATING_PICKUP_DATE = "coordinating_pickup_date"
    AWAITING_FOR_PICKUP = "awaiting_for_pickup"
    COLLECTED = "collected"
  end
  
  has_one    :donation
  belongs_to :material
  belongs_to :user
  belongs_to :location
  
  validates :user_id, :quantity, :units, :material, presence: true
  
  before_save :raise_donation_if_needed
  
  def self.available_units
    [Units::BAGS, Units::PIECES, Units::KILOS]
  end
  
  def self.units_hash
    self.available_units.inject(Hash.new) do |collection, unit|
      collection[unit.to_sym] = I18n.t("activerecord.values.offer.units.#{unit}.many")
      collection
    end
  end
  
  def self.available_status
    [Status::PENDING_REVIEW, 
     Status::REVIEWING, 
     Status::COORDINATING_PICKUP_DATE, 
     Status::AWAITING_FOR_PICKUP, 
     Status::COLLECTED]
  end
  
  def self.status_hash
    self.available_status.inject(Hash.new) do |collection, status|
      collection[status.to_sym] = I18n.t('activerecord.values.offer.status')[status.to_sym]
      collection
    end
  end
  
  def self.message_hash
    self.available_status.inject(Hash.new) do |collection, status|
      collection[status.to_sym] = I18n.t('activerecord.values.offer.messages_for_status')[status.to_sym]
      collection
    end
  end
  
  def self.create_with_location(params_for_offer, params_for_location, user)
    offer_params = self.extract_offer_params(params_for_offer).merge({ user_id: user.id })
    location_params = self.extract_location_params(params_for_location).merge({ user_id: user.id })
    
    offer = Offer.new(offer_params)
    location = Location.new(location_params)

    ActiveRecord::Base.transaction do
      if location.save!
        offer.location_id = location.id
        offer.save!
      end
    end
    
    [offer, location]
  end
  
  def zone
    location.localized_zone
  end
  
  def localized_status
    I18n.t('activerecord.values.offer.status')[self.status.to_sym]
  end
  
  def localized_units
    plural = quantity == 1 ? :one : :many
    I18n.t('activerecord.values.offer.units')[self.units.to_sym][plural]
  end
  
  def offer_title
    "#{material.localized_name} - #{quantity} #{localized_units}"
  end
  
  def published_on_discover
    return "Si" if !self.donation.nil? && self.status.eql?(Status::COLLECTED)
    "No"
  end
  
  def raise_donation_if_needed
    if self.status.eql?(Status::COLLECTED) && self.donation.blank?
      Donation.create(offer: self, is_fake: false)      
    elsif !self.donation.nil?
      self.donation.destroy!
    end
    
  end
  
  def expose_custom_json
    { 
      id: id,
      title: offer_title,
      message: Offer.message_hash[self.status.to_sym] || I18n.t('activerecord.values.offer.message.default'),
      localizedStatus: localized_status,
      status: status,
      zone: zone
    }
  end
  
  protected
  
  def self.extract_location_params(params)
    place = params.delete(:place)
    formatted_address = place.delete(:formatted_address)
    location = place.delete(:geometry).delete(:location)
    place_id = place.delete(:place_id)
    
    {
      place_identifier: place_id,
      lat: location.delete(:lat),
      lng: location.delete(:lng),
      address: formatted_address,
      zone: params.delete(:zone)
    }
  end
  
  def self.extract_offer_params(params)
    material_value = params.delete(:material)
    quantity = params.delete(:quantity)
    units = params.delete(:units)
    
    material = Material.where(value: material_value).first
    
    { 
      quantity: quantity,
      material_id: material.id,
      units: units
    }
  end
end
