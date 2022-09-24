# frozen_string_literal: true

class ShopController < ApplicationController
  def hours
    @shop = Shop.find(params['id'])
    @hours = JSON.parse(@shop.business_hours.first.opening_period)
  end
end
