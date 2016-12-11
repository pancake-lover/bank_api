require 'iso_country_codes'

class CountryCodeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless (IsoCountryCodes.find(value) rescue false)
      record.errors[attribute] << "is not a correct 3-char ISO country code"
    end
  end
end
