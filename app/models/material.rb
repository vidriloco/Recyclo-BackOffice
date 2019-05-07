class Material < ApplicationRecord
  has_many :offers
  
  validates :value, presence: true
  
  def localized_name
    I18n.t('activerecord.values.material.types')[self.value.to_sym]
  end
  
  def expose_custom_json
    { value: self.value, enabled: self.enabled, humanized: self.localized_name, image: self.image_url }
  end
end
