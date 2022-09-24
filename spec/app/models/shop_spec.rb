# frozen_string_literal: true
require "rails_helper"

RSpec.describe Shop do
  subject(:shop) { Shop.new(name:) }

  context 'when created with no name' do
    let(:name) { nil }
    it 'is invalid' do
      expect(shop).to_not be_valid
    end
  end

  context 'when created with a name with length 3' do
    let(:name) { 'poc' }
    it 'is valid' do
      expect(shop).to be_valid
    end
  end
end
