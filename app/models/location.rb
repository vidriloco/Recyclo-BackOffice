class Location < ApplicationRecord
  has_many :offers
  belongs_to :user
  
  validates :user_id, :lat, :lng, :zone, :address, presence: true
  
  module Zones
    ROMA_SUR = "Roma Sur"
    ROMA_NORTE = "Roma Norte"
    CONDESA = "Hipódromo Condesa"
    JUAREZ = "Juárez"
    CUAUHTEMOC = "Cuauhtemoc"
  end
  
  def self.zones
    { "roma-sur" => Zones::ROMA_SUR, "roma-norte" => Zones::ROMA_NORTE, "condesa" => Zones::CONDESA, "juarez" => Zones::JUAREZ, "cuauhtemoc" => Zones::CUAUHTEMOC }
  end
  
  def localized_zone
    self.zones[self.zone]
  end
  
  def self.all_fake
    self.locations_cuauhtemoc.concat(self.locations_juarez).concat(self.locations_roma).concat(self.locations_condesa)
  end
  
  def self.locations_condesa
    [{ coordinates: "19.416808, -99.175312" , zone: Location::Zones::CONDESA },
     { coordinates: "19.415968, -99.177468", zone: Location::Zones::CONDESA },
     { coordinates: "19.415867, -99.178493", zone: Location::Zones::CONDESA },
     { coordinates: "19.413034, -99.177935", zone: Location::Zones::CONDESA },
     { coordinates: "19.416803, -99.175210", zone: Location::Zones::CONDESA },
     { coordinates: "19.409893, -99.169438", zone: Location::Zones::CONDESA },
     { coordinates: "19.411588, -99.181709", zone: Location::Zones::CONDESA },
     { coordinates: "19.414005, -99.167944", zone: Location::Zones::CONDESA },
     { coordinates: "19.407609, -99.171880", zone: Location::Zones::CONDESA },
     { coordinates: "19.406105, -99.176502", zone: Location::Zones::CONDESA },
     { coordinates: "19.412254, -99.172324", zone: Location::Zones::CONDESA },
     { coordinates: "19.414786, -99.172384", zone: Location::Zones::CONDESA }]
  end
  
  def self.locations_cuauhtemoc
    [{ coordinates: "19.434422, -99.169496" , zone: Location::Zones::CUAUHTEMOC },
     { coordinates: "19.432753, -99.167973", zone: Location::Zones::CUAUHTEMOC },
     { coordinates: "19.430912, -99.170473", zone: Location::Zones::CUAUHTEMOC },
     { coordinates: "19.428372, -99.172640", zone: Location::Zones::CUAUHTEMOC },
     { coordinates: "19.426146, -99.173284", zone: Location::Zones::CUAUHTEMOC },
     { coordinates: "19.430309, -99.165215", zone: Location::Zones::CUAUHTEMOC },
     { coordinates: "19.426156, -99.170655", zone: Location::Zones::CUAUHTEMOC },
     { coordinates: "19.430997, -99.163461", zone: Location::Zones::CUAUHTEMOC },
     { coordinates: "19.432373, -99.163026", zone: Location::Zones::CUAUHTEMOC },
     { coordinates: "19.431533, -99.160827", zone: Location::Zones::CUAUHTEMOC },
     { coordinates: "19.430638, -99.162592", zone: Location::Zones::CUAUHTEMOC }]
  end
  
  def self.locations_juarez
    [{ coordinates: "19.422463, -99.169931", zone: Location::Zones::JUAREZ },
     { coordinates: "19.425334, -99.160377", zone: Location::Zones::JUAREZ },
     { coordinates: "19.424080, -99.171578", zone: Location::Zones::JUAREZ },
     { coordinates: "19.423513, -99.166256", zone: Location::Zones::JUAREZ },
     { coordinates: "19.427883, -99.157115", zone: Location::Zones::JUAREZ },
     { coordinates: "19.428733, -99.157973", zone: Location::Zones::JUAREZ },
     { coordinates: "19.425941, -99.161235", zone: Location::Zones::JUAREZ }]
  end
  
  def self.locations_roma
    [{ coordinates: "19.409589, -99.167012", zone: Location::Zones::ROMA_SUR },
     { coordinates: "19.408415, -99.165188", zone: Location::Zones::ROMA_SUR },
     { coordinates: "19.407969, -99.161991", zone: Location::Zones::ROMA_SUR },
     { coordinates: "19.404468, -99.162978", zone: Location::Zones::ROMA_SUR },
     { coordinates: "19.402667, -99.167827", zone: Location::Zones::ROMA_SUR },
     { coordinates: "19.402869, -99.165896", zone: Location::Zones::ROMA_SUR },
     { coordinates: "19.404387, -99.158107", zone: Location::Zones::ROMA_SUR },
     { coordinates: "19.406087, -99.159330", zone: Location::Zones::ROMA_SUR },
     { coordinates: "19.407646, -99.161132", zone: Location::Zones::ROMA_SUR },
     { coordinates: "19.424061, -99.156703", zone: Location::Zones::ROMA_NORTE },
     { coordinates: "19.420702, -99.157734", zone: Location::Zones::ROMA_NORTE },
     { coordinates: "19.418638, -99.160996", zone: Location::Zones::ROMA_NORTE },
     { coordinates: "19.412203, -99.162241", zone: Location::Zones::ROMA_NORTE },
     { coordinates: "19.417910, -99.171167", zone: Location::Zones::ROMA_NORTE },
     { coordinates: "19.420622, -99.174128", zone: Location::Zones::ROMA_NORTE },
     { coordinates: "19.417424, -99.166661", zone: Location::Zones::ROMA_NORTE },
     { coordinates: "19.416209, -99.154816", zone: Location::Zones::ROMA_NORTE }]
  end
end
