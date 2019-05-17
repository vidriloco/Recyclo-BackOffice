class Material < ApplicationRecord
  has_many :offers
  has_many :donations
  
  validates :value, presence: true
  
  module Types
    CAN = "aluminium-can"
    CARDBOARD = "paper-cardboard"
    PLASTIC = "plastic-pet"
    PAPER = "paper-newspaper"
  end
  
  def localized_name
    I18n.t('activerecord.values.material.types')[self.value.to_sym]
  end
  
  def enabled_humanized
    enabled ? "Si" : "No"
  end
  
  def expose_custom_json
    { value: self.value, enabled: self.enabled, humanized: self.localized_name, image: self.image_url }
  end
end
