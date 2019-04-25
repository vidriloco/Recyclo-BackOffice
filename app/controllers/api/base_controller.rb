class Api::BaseController < ApplicationController
  protect_from_forgery prepend: true
end