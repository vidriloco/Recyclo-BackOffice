class Api::BaseController < ApplicationController
  protect_from_forgery prepend: true
  
  protected

  def is_authorized
    if user_with_token.nil?
      render json: { error: "Parece ser que no estás logeado :/" }, status: 400
    end
  end

  def user_with_token
    return unless api_token
    User.where(remember_token: api_token).first
  end

  def authenticate_via_token
    user = user_with_token
    sign_in user if user
    cookies.delete(:remember_token) # so non-browser clients don't act like browsers and persist sessions in cookies
  end

  private

  def api_token
    pattern = /^Bearer /
    header  = request.env["HTTP_AUTHORIZATION"]
    header.gsub(pattern, '') if header && header.match(pattern)
  end
end