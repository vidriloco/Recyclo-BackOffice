class Material < ApplicationRecord
  validates :value, presence: true
  
  def humanized
    I18n.t('activerecord.values.material.types')[self.value.to_sym]
  end
  
  def expose_custom_json
    { value: self.value, enabled: self.enabled, humanized: self.humanized }
  end
end
