class User < ApplicationRecord
  include Clearance::User
  
  validates :username, length: { within: 4..12 }
  validates :username, :email, :password, presence: true
  validates :username, uniqueness: true
  validates :password, length: { within: 6..20 }
end
