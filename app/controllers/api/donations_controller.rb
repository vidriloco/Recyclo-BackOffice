class Api::DonationsController < Api::BaseController
  # Fix this ugly hack
  include ActionView::Helpers::DateHelper

  before_action :is_authorized
  
  def index
    @donations = Donation.all
    
    # Fix this ugly hack and render this JSON properly
    render json: { donations: @donations.map { |donation| donation.expose_selected_fields.merge(date: distance_of_time_in_words(donation.updated_at, DateTime.now)) } }, status: 200
  end
  
end
