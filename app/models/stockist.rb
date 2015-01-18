class Stockist < ActiveRecord::Base
  belongs_to :country
  after_validation :geocode #, if: ->(obj){ obj.address.present? and obj.address.changed? }
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  geocoded_by :address

  def address
    [street_address, city, state, country].compact.join(', ')
  end
end
