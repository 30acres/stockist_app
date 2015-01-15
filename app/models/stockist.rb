class Stockist < ActiveRecord::Base
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  geocoded_by :address

  def address
    [street, city, state, country].compact.join(', ')
  end
end
