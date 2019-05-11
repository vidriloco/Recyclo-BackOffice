class Avatar < ApplicationRecord
  
  has_many :donations
  
  def expose_custom_json
    { 
      id: id,
      name: name,
      url: url
    }
  end
end
