class Donation < ApplicationRecord
  
  belongs_to :material, optional: true
  belongs_to :offer, optional: true
  belongs_to :avatar, optional: true
  
  def self.create_fake_donation_given_by(user_name)
    location = Location.all_fake.shuffle.first
    lat, lng = location[:coordinates].split(",")
    
    donation_combo = self.fake_donation_combinations.shuffle.first
    subtitle, material = self.fake_donation_title_and_material(donation_combo)
    
    self.create({ 
      fake_title: user_name, 
      fake_subtitle: subtitle, 
      fake_latitude: lat, 
      fake_longitude: lng, 
      material: material, 
      avatar: Avatar.all.shuffle.first,
      fake_zone: location[:zone]
    })
  end
  
  def self.fake_donation_combinations
    [{ material: Material::Types::CAN, quantity: (100..300), units: Offer::Units::PIECES },
     { material: Material::Types::CAN, quantity: (3..5), units: Offer::Units::KILOS },
     { material: Material::Types::CAN, quantity: (3..8), units: Offer::Units::BAGS },
     { material: Material::Types::CARDBOARD, quantity: (30..50), units: Offer::Units::PIECES },
     { material: Material::Types::CARDBOARD, quantity: (5..30), units: Offer::Units::KILOS },
     { material: Material::Types::PLASTIC, quantity: (3..5), units: Offer::Units::KILOS },
     { material: Material::Types::PLASTIC, quantity: (100..200), units: Offer::Units::PIECES },
     { material: Material::Types::PAPER, quantity: (5..20), units: Offer::Units::KILOS }
    ]
  end
  
  def self.fake_donation_title_and_material(combination)
    material = Material.where(value: combination[:material]).first
    offer = Offer.new(quantity: combination[:quantity].to_a.shuffle.first, material: material, units: combination[:units])
    
    return [offer.offer_title, material]
  end
  
  def subtitle_in_discover_section
    is_fake ? fake_subtitle : offer.offer_title
  end
  
  def title_in_discover_section
    is_fake ? fake_title : offer.user.name.split(' ').first
  end
   
  def donation_type
    is_fake ? "Dummy" : "Real completada"
  end
  
  def expose_selected_fields
    { 
      title: fake_title,
      subtitle: fake_subtitle,
      latitude: fake_latitude,
      longitude: fake_longitude,
      material: material.image_url,
      avatar: avatar.url,
      zone: fake_zone,
      date: updated_at
    }
  end
  
end
