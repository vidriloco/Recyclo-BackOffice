class User < ApplicationRecord
  include Clearance::User
  
  has_many :offers
  has_many :locations
  
  validates :avatar_url, :username, :email, presence: true
  validates :username, :email, uniqueness: true
  
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t('activerecord.errors.messages.email') }
  validates :username, format: { with: /\A(\w){3,15}\z/, message: I18n.t('activerecord.errors.messages.username') }
  
  validates :password, length: { within: 6..20 }, unless: Proc.new { |a| a.password.blank? }
  validates :password, presence: true, unless: Proc.new { |a| a.password.blank? }

  before_validation do
    self.avatar_url = Avatar.all.shuffle.first.url  if avatar_url.blank?
  end
  
  def campaign_details
    return "No disponible" unless via_campaign
    campaign_code
  end
  
  def expose_custom_json
    { 
      username: username,
      name: name,
      email: email,
      phone: phone,
      avatar: avatar_url
    }
  end
  
  def updated_attributes?(params)
    name = params.delete(:name)
    self.update_attribute(:name, name) unless name.blank?
  
    username = params.delete(:username)
    self.update_attribute(:username, username) unless username.blank?
  
    email = params.delete(:email)
    self.update_attribute(:email, email) unless email.blank?
  
    password = params.delete(:password)
    self.update_attribute(:password, password) unless password.blank?
  
    phone = params.delete(:phone)
    self.update_attribute(:phone, phone) unless phone.blank?
    
    avatar = params.delete(:avatar)
    self.update_attribute(:avatar_url, avatar) unless avatar.blank?

    valid?
  end
end
