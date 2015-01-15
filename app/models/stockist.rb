class Stockist < ActiveRecord::Base
  after_validation :geocode #, if: ->(obj){ obj.address.present? and obj.address.changed? }
  geocoded_by :address

  def address
    [street_address, city, state, country].compact.join(', ')
  end
end
