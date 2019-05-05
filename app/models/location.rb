class Location < ApplicationRecord
  has_many :offers
  belongs_to :user
  
  validates :user_id, :lat, :lng, :zone, :address, presence: true
end
