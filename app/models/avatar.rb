class Avatar < ApplicationRecord
  def self.get_first_randomly
   ["https://media.giphy.com/media/GObRHYaUQWf3q/giphy.gif",
    "https://media.giphy.com/media/12QMzVeF4QsqTC/giphy.gif",
    "https://media.giphy.com/media/APPbIpIe0xrVe/giphy.gif",
    "https://media.giphy.com/media/KhlVSyjsbx18A/giphy.gif"].shuffle.first
  end
end
