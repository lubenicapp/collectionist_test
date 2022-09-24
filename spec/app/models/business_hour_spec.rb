# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BusinessHour do
  subject(:business_hour) { BusinessHour.new(opening_period:, shop_id:) }
  let(:shop_id) { Shop.find_by(name: 'casino').id }

  before(:all) do
    Shop.find_by(name: 'casino')&.delete
    shop = Shop.new(name: 'casino')
    shop.save
  end

  after(:all) do
    Shop.find_by(name: 'casino').delete
  end

  context 'when opening_period is an invalid JSON' do
    let(:opening_period) { 'not a json' }
    it 'is invalid' do
      expect(business_hour).not_to be_valid
    end
  end

  context 'when opening_period does not describe all days of week' do
    let(:opening_period) { '{"days": {"0": []}' }
    it 'is invalid' do
      expect(business_hour).not_to be_valid
    end
  end

  context 'when opening_period is in the right format' do
    let(:opening_period) { File.read('data/default_opening_period.json') }
    it 'is valid' do
      expect(business_hour).to be_valid
    end
  end

  context 'when opening_period hour period overlaps' do
    let(:opening_period) { File.read('data/wrong.json') }
    it 'is invalid' do
      expect(business_hour).not_to be_valid
    end
  end

  context 'when opening_period hours are invalid' do
    let(:opening_period) { File.read('data/wrong_hours.json') }
    it 'is invalid' do
      expect(business_hour).not_to be_valid
    end
  end

  context 'when opening_period are invalid' do
    let(:opening_period) { File.read('data/wrong_period.json') }
    it 'is invalid' do
      expect(business_hour).not_to be_valid
    end
  end
end
