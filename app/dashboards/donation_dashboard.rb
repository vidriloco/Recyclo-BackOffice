require "administrate/base_dashboard"

class DonationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    material: Field::BelongsTo,
    offer: Field::BelongsTo,
    avatar: Field::BelongsTo,
    id: Field::Number,
    location_id: Field::Number,
    is_fake: Field::Boolean,
    donation_type: Field::String.with_options(searchable: false),
    title_in_discover_section: Field::String.with_options(searchable: false),
    subtitle_in_discover_section: Field::String.with_options(searchable: false),
    fake_title: Field::String,
    fake_subtitle: Field::String,
    fake_latitude: Field::Number.with_options(decimals: 2),
    fake_longitude: Field::Number.with_options(decimals: 2),
    fake_zone: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :donation_type,
    :title_in_discover_section,
    :subtitle_in_discover_section,
    :offer,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :offer,
    :donation_type,
    :title_in_discover_section,
    :subtitle_in_discover_section,
    :fake_latitude,
    :fake_longitude,
    :fake_zone,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :fake_title
  ].freeze

  # Overwrite this method to customize how donations are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(donation)
    I18n.t('activerecord.models.donation.one')
  end
end
