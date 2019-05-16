require "administrate/base_dashboard"

class OfferDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    published_on_discover: Field::String.with_options(searchable: false),
    material: Field::BelongsTo,
    offer_title: Field::String.with_options(searchable: false),
    localized_status: Field::String.with_options(searchable: false),
    zone: Field::String.with_options(searchable: false),
    donation: Field::HasOne,
    user: Field::BelongsTo,
    location: Field::BelongsTo,
    id: Field::Number,
    quantity: Field::Number,
    units: Field::String,
    status: Field::String,
    message: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :published_on_discover,
    :offer_title,
    :localized_status,
    :user,
    :zone,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :published_on_discover,
    :material,
    :user,
    :location,
    :id,
    :quantity,
    :units,
    :status,
    :message,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :material,
    :user,
    :location,
    :quantity,
    :units,
    :status,
    :message,
  ].freeze

  # Overwrite this method to customize how offers are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(offer)
    "#{offer.offer_title} por #{offer.user.email}"
  end
  
  def self.display_offer_units_for(resource)
    Offer.units_hash[resource.units.to_sym].capitalize
  end
  
  def self.display_offer_status_for(resource)
    Offer.status_hash[resource.status.to_sym].capitalize
  end
  
  def self.offer_units
    Offer.units_hash.map { |k, v| [v.capitalize, k] }
  end
  
  def self.offer_status
    Offer.status_hash.map { |k, v| [v.capitalize, k] }
  end
  
  def self.offer_message_for(offer)
    Offer.message_hash[offer.status.to_sym]
  end
end
