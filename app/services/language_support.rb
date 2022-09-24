# frozen_string_literal: true

module LanguageSupport
  def set_locale(country)
    country = country&.downcase&.to_sym
    if I18n.available_locales.include?(country)
      I18n.locale = country
    else
      I18n.locale = I18n.available_locales.first
    end
  end
end
