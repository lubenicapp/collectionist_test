require 'rails_helper'

RSpec.describe "Shops", type: :request do

  before(:all) do
    Shop.delete_all
    BusinessHour.delete_all
    shop = Shop.new(name: 'lidl')
    shop.save
    business_hours = BusinessHour.new
    business_hours.opening_period = File.read('data/default_opening_period.json')
    business_hours.shop_id = shop.id
    business_hours.save
  end

  after(:all) do
    Shop.delete_all
    BusinessHour.delete_all
  end

  let(:shop_id) { Shop.first.id }

  describe "GET /shops/id/business_hours" do
    context 'with valid id' do
      it 'returns a success status code' do
        get "/shops/#{shop_id}/business_hours"
        expect(response).to have_http_status(:success)
      end
    end
  end
end
