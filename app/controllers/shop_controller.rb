# frozen_string_literal: true

class ShopController < ApplicationController
  include LanguageSupport
  def hours
    @country = Geocoder.search(request.remote_ip)&.first&.country&.downcase
    set_locale(@country)
    @shop = Shop.find(params['id'])
    @hours = JSON.parse(@shop.business_hours.first.opening_period)
  end
end
