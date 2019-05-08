class User < ApplicationRecord
  include Clearance::User
  
  has_many :offers
  has_many :locations
  
  validates :username, length: { within: 4..12 }
  validates :username, :email, :password, presence: true
  validates :username, uniqueness: true
  validates :password, length: { within: 6..20 }
  validates :avatar_url, :username, :email, presence: true
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
