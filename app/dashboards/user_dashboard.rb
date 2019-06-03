require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    offers: Field::HasMany,
    locations: Field::HasMany,
    id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    name: Field::String,
    username: Field::String,
    email: Field::String,
    phone: Field::String,
    campaign_code: Field::String,
    via_campaign: Field::Boolean,
    encrypted_password: Field::String,
    confirmation_token: Field::String,
    remember_token: Field::String,
    avatar_url: Field::String,
    campaign_details: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :email,
    :username,
    :offers,
    :locations,
    :created_at,
    :campaign_details
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :offers,
    :locations,
    :id,
    :created_at,
    :updated_at,
    :name,
    :username,
    :email,
    :phone,
    :campaign_details,
    :encrypted_password,
    :confirmation_token,
    :remember_token,
    :avatar_url,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :offers,
    :locations,
    :name,
    :username,
    :email,
    :phone,
    :encrypted_password,
    :confirmation_token,
    :remember_token,
    :avatar_url,
  ].freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(user)
    user.email
  end
end
