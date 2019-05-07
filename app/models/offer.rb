class Offer < ApplicationRecord
  belongs_to :material
  belongs_to :user
  belongs_to :location
  
  validates :user_id, :quantity, :units, :material, presence: true
  
  def self.states
    {
      pending_review: 'pending-review',
      reviewing: 'reviewing',
      coordinating_pickup_date: 'coordinating-pickup-date',
      awaiting_for_pickup: 'awaiting-for-pickup',
      collected: 'collected'
    }
  end
  
  def self.units
    {
      bags: "bags",
      pieces: "pieces",
      kilos: "kilos"
    }
  end
  
  def localized_status
    I18n.t('activerecord.values.offers.status')[self.status.to_sym]
  end
  
  def localized_units
    plural = quantity == 1 ? :one : :many
    I18n.t('activerecord.values.offers.units')[self.units.to_sym][plural]
  end
  
  def offer_title
    "#{material.localized_name} - #{quantity} #{localized_units}"
  end
  
  def expose_custom_json
    { 
      title: offer_title,
      message: message || I18n.t('activerecord.values.offers.message.default'),
      localizedStatus: localized_status,
      status: status,
      zone: location.localized_zone
    }
  end
end
