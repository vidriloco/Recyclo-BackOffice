class Offer < ApplicationRecord
  belongs_to :material
  belongs_to :user
  
  validates :quantity, :zone, :units, :material, presence: true
  
  def self.states
    {
      pending_review: 'pending-review',
      reviewing: 'reviewing',
      coordinating_pickup_date: 'coordinating-pickup-date',
      awaiting_for_pickup: 'awaiting-for-pickup',
      collected: 'collected'
    }
  end
end
