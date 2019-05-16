require "administrate/base_dashboard"

class MaterialDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    localized_name: Field::String,
    offers: Field::HasMany,
    donations: Field::HasMany,
    id: Field::Number,
    value: Field::String,
    enabled: Field::Boolean,
    image_url: Field::String,
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
    :localized_name
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :localized_name,
    :enabled,
    :image_url,
    :created_at,
    :updated_at,
    :offers,
    :donations,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :offers,
    :donations,
    :value,
    :enabled,
    :image_url,
  ].freeze

  # Overwrite this method to customize how materials are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(material)
    I18n.t('activerecord.values.material.types')[material.value.to_sym]
  end
end
