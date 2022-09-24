# frozen_string_literal: true

class Shop < ApplicationRecord
  has_many :business_hours

  validates :name,
            presence: true,
            length: { minimum: 3 },
            uniqueness: true
end
