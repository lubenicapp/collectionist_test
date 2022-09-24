# frozen_string_literal: true

# validate if opening period is a valid JSON
class ValidateJsonFormat < ActiveModel::Validator
  def validate(record)
    JSON.parse(record.opening_period)
  rescue JSON::ParserError
    record.errors.add :opening_period, "opening_period must be a valid json"
  end
end

# validates if all days of week are described in the JSON
class ValidateDayOfWeeks < ActiveModel::Validator
  def validate(record)
    record.errors.add :days, "days must contains exactly key from 0 to 6" unless
      JSON.parse(record.opening_period)['days'].keys == %w[0 1 2 3 4 5 6]
  rescue JSON::ParserError
    false
  end
end

# validates if described hour are legit
class ValidateHourOverlapping < ActiveModel::Validator
  def validate(record)
    days = JSON.parse(record.opening_period)['days']
    days.values.each do |hours|
      record.errors.add :hours, "hours overlap" unless
        hours.flatten.sort == hours.flatten
    end
  rescue JSON::ParserError
    false
  end
end

# validates if hours are in the right format
class ValidateHourFormat < ActiveModel::Validator
  def validate(record)
    hours = JSON.parse(record.opening_period)['days'].values.flatten
    hours.each do |h|
      record.errors.add :hour, "hour is invalid" unless
        h.match?(/^[0-2][0-9]:[0-2][0-9]$/)
    end
  rescue JSON::ParserError
    false
  end
end

class BusinessHour < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :shop

  validates :opening_period,
            presence: true

  validates_with ValidateJsonFormat
  validates_with ValidateDayOfWeeks
  validates_with ValidateHourOverlapping
  validates_with ValidateHourFormat
end
