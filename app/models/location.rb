class Location < ApplicationRecord
  has_many :offers
  belongs_to :user
  
  validates :user_id, :lat, :lng, :zone, :address, presence: true
  
  def localized_zone
    { "roma-sur" => "Roma Sur", "roma-norte" => "Roma Norte", "condesa" => "Condesa", "juarez" => "Juárez", "cuauhtemoc" => "Cuauhtemoc" }[self.zone]
  end
end
